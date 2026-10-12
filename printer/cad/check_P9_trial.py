"""Run with Blender 3.4: --background --factory-startup --python this_file."""

from pathlib import Path
import math
import unittest
import xml.etree.ElementTree as ET

import bmesh
import bpy
from mathutils import Vector
from mathutils.bvhtree import BVHTree


ROOT = Path(__file__).resolve().parent


class P9TrialTests(unittest.TestCase):
    def test_trial_files_exist(self):
        for name in ("P9_guide_cap_trial.stl", "P9_plate_trial.svg", "P9_assembly_trial.blend"):
            self.assertTrue((ROOT / name).is_file(), f"Missing trial output: {name}")

    def test_assembly_offsets_and_direct_metal_support(self):
        path = ROOT / "P9_assembly_trial.blend"
        self.assertTrue(path.is_file(), "Missing trial assembly")
        bpy.ops.wm.open_mainfile(filepath=str(path))
        objects = bpy.data.objects
        plate = objects["METAL_plate_60x50x3_NOT_FOR_3D_PRINT"]
        pipe = objects["pipe_15x15_wall_1p5"]
        cap = objects["P9_guide_cap_TRIAL"]
        spacer = objects["METAL_KNCLM5_8_12_ID5p2_NOMINAL_TRIAL"]
        profile = objects["2020_ENVELOPE_ONLY_NO_SLOT_GEOMETRY"]
        self.assertAlmostEqual(pipe.location.y - profile.location.y, 17.5)
        self.assertAlmostEqual(cap.location.y, pipe.location.y)
        for actual, expected in zip(plate.dimensions, (60, 50, 3)):
            self.assertAlmostEqual(actual, expected)
        plate_top = max((plate.matrix_world @ Vector(v)).z for v in plate.bound_box)
        pipe_bottom = min((pipe.matrix_world @ Vector(v)).z for v in pipe.bound_box)
        self.assertAlmostEqual(plate_top, pipe_bottom)
        self.assertAlmostEqual(spacer.dimensions.z, 12)
        self.assertEqual(spacer["supplier_tolerances_mm"], "OD7.8..8.0; ID5.1..5.3; L11.9..12.0")
        self.assertIn("TRIAL ONLY", bpy.context.scene["status"])

    def test_cap_dimensions_manifold_volume_and_clearances(self):
        path = ROOT / "P9_guide_cap_trial.stl"
        self.assertTrue(path.is_file(), "Missing trial STL")
        bpy.ops.object.select_all(action="SELECT")
        bpy.ops.object.delete(use_global=False)
        bpy.ops.import_mesh.stl(filepath=str(path))
        obj = bpy.context.selected_objects[0]
        for actual, expected in zip(obj.dimensions, (38.0, 24.0, 8.0)):
            self.assertAlmostEqual(actual, expected, places=3)
        mesh = bmesh.new()
        mesh.from_mesh(obj.data)
        self.assertTrue(all(edge.is_manifold for edge in mesh.edges))
        self.assertTrue(all(face.normal.length > 0.99 for face in mesh.faces))
        expected_volume = 38 * 24 * 8 - 38 * 15.4 * 5 - math.pi * 2.75**2 * 3
        self.assertAlmostEqual(mesh.calc_volume(signed=True), expected_volume, delta=0.2)
        tree = BVHTree.FromBMesh(mesh)
        down = Vector((0, 0, -1))
        for x in (0.0, 2.70):
            self.assertIsNone(tree.ray_cast(Vector((x, 0, 9)), down)[0])
        hit = tree.ray_cast(Vector((2.80, 0, 9)), down)[0]
        self.assertIsNotNone(hit)
        self.assertAlmostEqual(hit.z, 8.0, places=3)
        up = Vector((0, 0, 1))
        for y, expected_z in ((0.0, 5.0), (7.60, 5.0), (7.80, 0.0)):
            hit = tree.ray_cast(Vector((8, y, -1)), up)[0]
            self.assertIsNotNone(hit)
            self.assertAlmostEqual(hit.z, expected_z, places=3)
        mesh.free()

    def test_metal_plate_hole_coordinates_and_warnings(self):
        path = ROOT / "P9_plate_trial.svg"
        self.assertTrue(path.is_file(), "Missing trial SVG")
        root = ET.parse(path).getroot()
        ns = {"s": "http://www.w3.org/2000/svg"}
        plate = root.find(".//s:rect[@id='metal-plate']", ns)
        self.assertIsNotNone(plate)
        self.assertEqual((float(plate.get("width")), float(plate.get("height"))), (300, 250))
        holes = root.findall(".//s:circle[@data-part='plate-hole']", ns)
        self.assertEqual(len(holes), 3)
        expected = {(-15.0, 0.0), (15.0, 0.0), (0.0, 17.5)}
        actual = set()
        for hole in holes:
            x = (float(hole.get("cx")) - 100) / 5 - 30
            y = 40 - (float(hole.get("cy")) - 100) / 5
            actual.add((x, y))
            self.assertEqual(float(hole.get("r")) * 2 / 5, 5.5)
        self.assertEqual(actual, expected)
        text = " ".join(root.itertext())
        self.assertIn("TRIAL ONLY", text)
        self.assertIn("NOT TO SCALE", text)
        self.assertIn("Do not 3D-print the load-bearing plate", text)


result = unittest.TextTestRunner(verbosity=2).run(
    unittest.defaultTestLoader.loadTestsFromTestCase(P9TrialTests)
)
if not result.wasSuccessful():
    raise SystemExit(1)

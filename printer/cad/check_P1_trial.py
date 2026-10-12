"""Check nominal P1 geometry in Blender; not a hardware fit or strength test."""

from pathlib import Path
import unittest
import xml.etree.ElementTree as ET

import bmesh
import bpy
from mathutils import Vector
from mathutils.bvhtree import BVHTree


ROOT = Path(__file__).resolve().parent


class P1TrialTests(unittest.TestCase):
    def test_slots_and_open_channel_in_exported_solid(self):
        path = ROOT / "P1_holder_adapter_trial.stl"
        self.assertTrue(path.is_file(), "Missing P1 trial STL")
        bpy.ops.object.select_all(action="SELECT")
        bpy.ops.object.delete(use_global=False)
        bpy.ops.import_mesh.stl(filepath=str(path))
        obj = bpy.context.selected_objects[0]
        for actual, expected in zip(obj.dimensions, (60, 40, 75)):
            self.assertAlmostEqual(actual, expected, places=3)
        mesh = bmesh.new()
        mesh.from_mesh(obj.data)
        self.assertTrue(all(e.is_manifold for e in mesh.edges))
        self.assertGreater(mesh.calc_volume(signed=True), 49000)
        self.assertLess(mesh.calc_volume(signed=True), 50500)
        tree = BVHTree.FromBMesh(mesh)
        for x in (-20, 0, 20):
            for z in (15, 37.5, 60):
                self.assertIsNone(tree.ray_cast(Vector((x, -1, z)), Vector((0, 1, 0)), 7)[0])
            self.assertIsNotNone(tree.ray_cast(Vector((x + 2.8, -1, 37.5)), Vector((0, 1, 0)), 7)[0])
        for x in (-10, 10):
            for z in (19.25, 40.75):
                for offset in (-6, 0, 6):
                    self.assertIsNone(tree.ray_cast(Vector((x, 41, z + offset)), Vector((0, -1, 0)), 7)[0])
                self.assertIsNotNone(tree.ray_cast(Vector((x + 1.75, 41, z)), Vector((0, -1, 0)), 7)[0])
        for x in (-24, 0, 24):
            self.assertIsNone(tree.ray_cast(Vector((x, 20, -1)), Vector((0, 0, 1)), 80)[0])
        mesh.free()

    def test_assembly_standoffs_and_m5_thread_engagement(self):
        path = ROOT / "P1_assembly_trial.blend"
        self.assertTrue(path.is_file(), "Missing P1 trial assembly")
        bpy.ops.wm.open_mainfile(filepath=str(path))
        obj = bpy.data.objects["P1_holder_adapter_TRIAL"]
        back_face = min((obj.matrix_world @ Vector(v)).y for v in obj.bound_box)
        self.assertAlmostEqual(back_face, 15)
        carrier = bpy.data.objects["GANTRY_SMALL_REFERENCE_NO_WHEELS_OR_BELT"]
        carrier_front = max((carrier.matrix_world @ Vector(v)).y for v in carrier.bound_box)
        self.assertAlmostEqual(carrier_front, 0)
        standoffs = [o for o in bpy.data.objects if o.name.startswith("METAL_M5_standoff_15")]
        self.assertEqual(len(standoffs), 2)
        self.assertEqual({round(o.location.z, 2) for o in standoffs}, {27.5, 47.5})
        for item in standoffs:
            ends = [(item.matrix_world @ Vector(v)).y for v in item.bound_box]
            self.assertAlmostEqual(min(ends), carrier_front, places=3)
            self.assertAlmostEqual(max(ends), back_face, places=3)
        front_engagement = 12 - 5 - 1
        rear_engagement = 10 - 3 - 1
        self.assertEqual((front_engagement, rear_engagement), (6, 6))
        self.assertLess(front_engagement + rear_engagement, 15)
        self.assertIn("TRIAL ONLY", bpy.context.scene["status"])

    def test_drawing_matches_exported_slot_positions(self):
        path = ROOT / "P1_dimensions_trial.svg"
        self.assertTrue(path.is_file(), "Missing P1 trial drawing")
        root = ET.parse(path).getroot()
        ns = {"s": "http://www.w3.org/2000/svg"}
        back = root.findall(".//s:rect[@data-part='back-slot']", ns)
        front = root.findall(".//s:rect[@data-part='holder-slot']", ns)
        self.assertEqual((len(back), len(front)), (3, 4))
        for item, x in zip(back, (-20, 0, 20)):
            self.assertAlmostEqual((float(item.get("x")) + float(item.get("width")) / 2 - 220) / 5, x)
            self.assertAlmostEqual(float(item.get("width")) / 5, 5.5)
            self.assertAlmostEqual(float(item.get("height")) / 5, 50.5)
        actual = {
            (round((float(p.get("x")) + float(p.get("width")) / 2 - 650) / 5, 2),
             round((470 - float(p.get("y")) - float(p.get("height")) / 2) / 5, 2))
            for p in front
        }
        self.assertEqual(actual, {(-10, 19.25), (10, 19.25), (-10, 40.75), (10, 40.75)})
        text = " ".join(root.itertext())
        self.assertIn("TRIAL ONLY", text)
        self.assertIn("NOT TO SCALE", text)


result = unittest.TextTestRunner(verbosity=2).run(
    unittest.defaultTestLoader.loadTestsFromTestCase(P1TrialTests)
)
if not result.wasSuccessful():
    raise SystemExit(1)

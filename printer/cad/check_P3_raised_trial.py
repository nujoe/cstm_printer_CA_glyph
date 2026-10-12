"""Check the raised guide and nominal feed alignment, not strength or real fit."""

from pathlib import Path
import unittest

import bmesh
import bpy
from mathutils import Vector
from mathutils.bvhtree import BVHTree

ROOT = Path(__file__).resolve().parent


class RaisedGuideTests(unittest.TestCase):
    def test_guide_and_feed_datum(self):
        path = ROOT / "P3_raised_guide_trial.stl"
        self.assertTrue(path.is_file(), "Missing raised guide for the low frame")
        bpy.ops.object.select_all(action="SELECT")
        bpy.ops.object.delete(use_global=False)
        bpy.ops.import_mesh.stl(filepath=str(path))
        obj = bpy.context.selected_objects[0]
        for actual, expected in zip(obj.dimensions, (87.5, 25, 15)):
            self.assertAlmostEqual(actual, expected, places=3)
        mesh = bmesh.new()
        mesh.from_mesh(obj.data)
        self.assertTrue(all(edge.is_manifold for edge in mesh.edges))
        self.assertGreater(mesh.calc_volume(signed=True), 27500)
        tree = BVHTree.FromBMesh(mesh)
        for y in (-7.5, 7.5):
            self.assertIsNone(tree.ray_cast(Vector((-8, y, -1)), Vector((0, 0, 1)), 17)[0])
        # Pipe centre Z30.5, P2 x=-25.5 there, guide translated x=-17.5.
        guide_to_world_z = 30.5 + 25.5 - 17.5
        lower_rod_z = 30.5 + 25.5 + 12.5
        upper_rod_z = lower_rod_z + 6 + 15  # nominal covered roller R6, bearing R15
        rod_local_x = upper_rod_z - guide_to_world_z
        self.assertEqual((lower_rod_z, upper_rod_z, rod_local_x), (68.5, 89.5, 51))
        self.assertGreater(rod_local_x - 5, 35)
        self.assertLess(rod_local_x + 5, 70)
        for x in (rod_local_x - 5, rod_local_x, rod_local_x + 5, 69.9):
            self.assertIsNone(tree.ray_cast(Vector((x, 0, 2.1)), Vector((0, 0, 1)), 14)[0])
        self.assertIsNotNone(tree.ray_cast(Vector((51, 0, -1)), Vector((0, 0, 1)), 3)[0])
        self.assertIsNotNone(tree.ray_cast(Vector((51, 5.2, -1)), Vector((0, 0, 1)), 17)[0])
        # The original guide would stop below the required upper-rod centre.
        self.assertLess(17.5 + guide_to_world_z, upper_rod_z - 5)
        mesh.free()


result = unittest.TextTestRunner(verbosity=2).run(
    unittest.defaultTestLoader.loadTestsFromTestCase(RaisedGuideTests)
)
if not result.wasSuccessful():
    raise SystemExit(1)

"""Blender checks for the slots and real bolt paths in the two new supports."""

from pathlib import Path
import unittest

import bmesh
import bpy
from mathutils import Vector
from mathutils.bvhtree import BVHTree

ROOT = Path(__file__).resolve().parent


class RollPlatenTrialTests(unittest.TestCase):
    def load(self, name):
        bpy.ops.object.select_all(action="SELECT")
        bpy.ops.object.delete(use_global=False)
        bpy.ops.import_mesh.stl(filepath=str(ROOT / name))
        obj = bpy.context.selected_objects[0]
        mesh = bmesh.new()
        mesh.from_mesh(obj.data)
        self.assertTrue(all(edge.is_manifold for edge in mesh.edges))
        self.addCleanup(mesh.free)
        return obj, BVHTree.FromBMesh(mesh)

    def test_platen_pipe_fit_and_independent_fastener_paths(self):
        obj, tree = self.load("P12_platen_saddle_trial.stl")
        for actual, expected in zip(obj.dimensions, (40, 40, 48.5)):
            self.assertAlmostEqual(actual, expected, places=3)
        down = Vector((0, 0, -1))
        for y in (-16, 16):
            self.assertIsNone(tree.ray_cast(Vector((0, y, 34)), down)[0])
        self.assertAlmostEqual(tree.ray_cast(Vector((0, 0, 34)), down)[0].z, 33.5)
        for x in (-10, 10):
            self.assertIsNone(tree.ray_cast(Vector((x, -21, -7.5)), Vector((0, 1, 0)))[0])
        # A 15 mm tube may enter from below without a printed floor beneath it.
        hit = tree.ray_cast(Vector((5, 7.5, -16)), Vector((0, 0, 1)))[0]
        self.assertAlmostEqual(hit.z, 0, places=3)

    def test_roll_drop_in_slot_base_holes_and_retaining_tie(self):
        obj, tree = self.load("P13_roll_stand_trial.stl")
        for actual, expected in zip(obj.dimensions, (60, 120, 110)):
            self.assertAlmostEqual(actual, expected, places=3)
        hit = tree.ray_cast(Vector((0, 0, 111)), Vector((0, 0, -1)))[0]
        self.assertAlmostEqual(hit.z, 94.7, places=2)
        self.assertIsNone(tree.ray_cast(Vector((0, -16, 80)), Vector((0, 1, 0)))[0])
        for x in (-20, 20):
            for y in (-45, 45):
                self.assertIsNone(tree.ray_cast(Vector((x, y, 9)), Vector((0, 0, -1)))[0])

    def test_centre_pipe_tee_has_through_channels_and_three_bolts(self):
        obj, tree = self.load("P14_centre_pipe_tee_half_trial.stl")
        for actual, expected in zip(obj.dimensions, (40, 40, 9.7)):
            self.assertAlmostEqual(actual, expected, places=3)
        for x, y in ((0, -12), (0, 12), (-12, 0)):
            self.assertIsNone(tree.ray_cast(Vector((x, y, 1)), Vector((0, 0, -1)))[0])
        for x, y in ((5, 18), (-18, 5)):
            hit = tree.ray_cast(Vector((x, y, 1)), Vector((0, 0, -1)))[0]
            self.assertAlmostEqual(hit.z, -7.6, places=3)


result = unittest.TextTestRunner(verbosity=2).run(
    unittest.defaultTestLoader.loadTestsFromTestCase(RollPlatenTrialTests)
)
if not result.wasSuccessful():
    raise SystemExit(1)

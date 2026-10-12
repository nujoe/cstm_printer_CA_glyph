"""Raised upper-roll guide for the low frame; replaces the original P3 only."""

from pathlib import Path
import sys

import bpy
from mathutils import Vector

ROOT = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from cad_geometry import box, bore, subtract

bpy.ops.object.select_all(action="SELECT")
bpy.ops.object.delete(use_global=False)

# Keep the original two mounting holes and 2mm blind back for the 400mm rod.
guide = box("P3_RAISED_GUIDE_TRIAL", (87.5, 25, 15), (26.25, 0, 7.5))
for y in (-7.5, 7.5):
    subtract(guide, bore("M3_clearance", 1.7, 17, (-8, y, 7.5)))
subtract(guide, box("open_top_rod_slot", (36, 10.2, 13.2), (53, 0, 8.6)))
guide["status"] = "FIT TRIAL: low-frame guide, not strength/printing approval"
guide["mount_holes"] = "(-8,-7.5),(-8,7.5); diameter3.4; original P2 pattern"
guide["global_transform"] = "local x -> world Z=x+38.5; local z -> inward from pipe face"
guide.color = (0.20, 0.49, 0.47, 1)
bpy.context.view_layer.objects.active = guide
guide.select_set(True)
bpy.ops.export_mesh.stl(filepath=str(ROOT / "P3_raised_guide_trial.stl"), use_selection=True)

scene = bpy.context.scene
scene.unit_settings.system = "METRIC"
scene.unit_settings.scale_length = 0.001
scene["status"] = "NOMINAL FIT TRIAL; real roller diameter, friction, load and print process unverified"
bpy.ops.object.camera_add(location=(140, -100, 110))
camera = bpy.context.object
camera.rotation_euler = (Vector((26, 0, 7.5)) - camera.location).to_track_quat("-Z", "Y").to_euler()
camera.data.type = "ORTHO"
camera.data.ortho_scale = 112
scene.camera = camera
scene.render.engine = "BLENDER_WORKBENCH"
scene.display.shading.color_type = "OBJECT"
scene.display.shading.light = "STUDIO"
scene.display.shading.show_shadows = True
scene.display.shading.show_cavity = True
scene.display.shading.background_type = "WORLD"
scene.world.color = (1, 1, 1)
scene.render.resolution_x = 1000
scene.render.resolution_y = 850
scene.render.resolution_percentage = 100
scene.render.filepath = str(ROOT / "P3_raised_guide_trial.png")
bpy.ops.wm.save_as_mainfile(filepath=str(ROOT / "P3_raised_guide_trial.blend"))
bpy.ops.render.render(write_still=True)
print("P3 fit-trial guide generated; print one first, not an assembly/strength approval.")

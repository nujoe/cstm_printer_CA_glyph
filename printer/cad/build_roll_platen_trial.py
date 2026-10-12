"""Two simple trial supports; fit and load tests follow receipt of the hardware."""

from pathlib import Path
import math
import sys

import bpy

ROOT = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from cad_geometry import box, bore, subtract

bpy.ops.object.select_all(action="SELECT")
bpy.ops.object.delete(use_global=False)

# The underside of the platen is 33.5 mm above the centre pipe's top face.
platen = box("P12_platen_saddle_TRIAL", (40, 40, 48.5), (0, 0, 9.25))
subtract(platen, box("pipe_channel", (42, 15.4, 15.4), (0, 0, -7.7)))
for y in (-16, 16):
    subtract(platen, bore("M4_plate_bolt", 2.25, 52, (0, y, 9.25)))
for x in (-10, 10):
    cut = bore("M4_pipe_clamp", 2.25, 42, (x, 0, -7.5))
    cut.rotation_euler.x = math.pi / 2
    subtract(platen, cut)
platen["plate_underside_from_pipe_top_mm"] = 33.5

stand = box("P13_roll_stand_TRIAL", (60, 120, 110), (0, 0, 55))
for y in (-37.6, 37.6):
    subtract(stand, box("upper_side_void", (62, 45.2, 104), (0, y, 60)))
cut = bore("M10_rod_saddle", 5.3, 62, (0, 0, 100))
cut.rotation_euler.y = math.pi / 2
subtract(stand, cut)
subtract(stand, box("rod_drop_in_opening", (62, 10.6, 14), (0, 0, 107)))
cut = bore("retaining_tie_tunnel", 3.5, 32, (0, 0, 80))
cut.rotation_euler.x = math.pi / 2
subtract(stand, cut)
for x in (-20, 20):
    for y in (-45, 45):
        subtract(stand, bore("M4_base_bolt", 2.25, 10, (x, y, 4)))
stand["nominal_rod_axis_from_base_mm"] = 100.0
stand["hold_down"] = "bolt base to metal plate; retaining tie through tunnel over rod"

tee = box("P14_centre_pipe_tee_HALF_TRIAL", (40, 40, 9.7), (0, 0, -4.85))
subtract(tee, box("side_pipe_channel", (15.4, 42, 15.2), (0, 0, 0)))
subtract(tee, box("branch_pipe_channel", (22, 15.4, 15.2), (-10, 0, 0)))
for x, y in ((0, -12), (0, 12), (-12, 0)):
    subtract(tee, bore("M3_pipe_bolt", 1.75, 12, (x, y, -4.85)))
tee["assembly"] = "two halves; side pipe along Y; branch enters from -X; use three M3 bolts"

for obj, filename in (
    (platen, "P12_platen_saddle_trial.stl"),
    (stand, "P13_roll_stand_trial.stl"),
    (tee, "P14_centre_pipe_tee_half_trial.stl"),
):
    obj["status"] = "TRIAL ONLY: dimensions nominal; no load, creep or fit test"
    bpy.ops.object.select_all(action="DESELECT")
    obj.select_set(True)
    bpy.context.view_layer.objects.active = obj
    bpy.ops.export_mesh.stl(filepath=str(ROOT / filename), use_selection=True)

stand.location.x = 90
tee.location.x = -65
tee.location.z = 15
bpy.context.scene["status"] = "PARTS ONLY: print one of each first; not full assembly approval"
bpy.ops.wm.save_as_mainfile(filepath=str(ROOT / "roll_platen_parts_trial.blend"))

from mathutils import Vector

for obj, color in ((platen, (0.2, 0.48, 0.62, 1)), (stand, (0.55, 0.57, 0.6, 1)), (tee, (0.62, 0.3, 0.18, 1))):
    obj.color = color
scene = bpy.context.scene
scene.render.engine = "BLENDER_WORKBENCH"
scene.display.shading.light = "STUDIO"
scene.display.shading.color_type = "OBJECT"
scene.display.shading.show_shadows = True
scene.display.shading.background_type = "WORLD"
scene.world.color = (0.92, 0.92, 0.92)
bpy.ops.object.camera_add(location=(240, -360, 255))
camera = bpy.context.object
camera.rotation_euler = (Vector((45, 0, 45)) - camera.location).to_track_quat("-Z", "Y").to_euler()
camera.data.type = "ORTHO"
camera.data.ortho_scale = 320
scene.camera = camera
scene.render.resolution_x = 1280
scene.render.resolution_y = 720
scene.render.resolution_percentage = 100
scene.render.filepath = str(ROOT / "roll_platen_parts_trial.png")
bpy.ops.render.render(write_still=True)
print("Generated P12/P13/P14 trial parts and preview; no physical fit/load approval.")

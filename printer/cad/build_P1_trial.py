"""Generate an adjustable P1 fit trial, not a manufacturing approval."""

from pathlib import Path
import math
import sys

import bpy
from mathutils import Vector


ROOT = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from cad_geometry import box, bore, subtract

bpy.ops.object.select_all(action="SELECT")
bpy.ops.object.delete(use_global=False)

adapter = box("P1_holder_adapter_TRIAL", (60, 5, 75), (0, 2.5, 37.5))
parts = [box("front_wall", (60, 5, 60), (0, 37.5, 30))]
parts += [box("side_wall", (4, 40, 60), (x, 20, 30)) for x in (-28, 28)]
for part in parts:
    bpy.context.view_layer.objects.active = adapter
    modifier = adapter.modifiers.new("join_wall", "BOOLEAN")
    modifier.operation = "UNION"
    modifier.solver = "EXACT"
    modifier.object = part
    bpy.ops.object.modifier_apply(modifier=modifier.name)
    bpy.data.objects.remove(part, do_unlink=True)


def slot(obj, x, y, z, diameter, straight_length):
    subtract(obj, box("slot_middle", (diameter, 7, straight_length), (x, y, z)))
    for end in (-straight_length / 2, straight_length / 2):
        tool = bore("slot_end", diameter / 2, 7, (x, y, z + end))
        tool.rotation_euler.x = math.pi / 2
        subtract(obj, tool)


for x in (-20, 0, 20):
    slot(adapter, x, 2.5, 37.5, 5.5, 45)
for x in (-10, 10):
    for z in (19.25, 40.75):
        slot(adapter, x, 37.5, z, 3.4, 12)

bpy.ops.object.select_all(action="DESELECT")
adapter.select_set(True)
bpy.context.view_layer.objects.active = adapter
bpy.ops.export_mesh.stl(filepath=str(ROOT / "P1_holder_adapter_trial.stl"), use_selection=True)
adapter.location.y += 15
adapter.color = (0.84, 0.27, 0.12, 1)
adapter["status"] = "TRIAL: actual Q2299A/gantry fit, nozzle height and strength unverified"

carrier = box("GANTRY_SMALL_REFERENCE_NO_WHEELS_OR_BELT", (65.5, 3, 65.5), (0, -1.5, 37.5))
for z in (27.5, 47.5):
    tool = bore("reference_M5_hole", 2.55, 5, (0, -1.5, z))
    tool.rotation_euler.x = math.pi / 2
    subtract(carrier, tool)
    bpy.ops.mesh.primitive_cylinder_add(vertices=6, radius=8 / math.sqrt(3), depth=15, location=(0, 7.5, z))
    standoff = bpy.context.object
    standoff.name = "METAL_M5_standoff_15_REFERENCE"
    standoff.rotation_euler.x = math.pi / 2
    tool = bore("M5_thread_envelope", 2.5, 17, (0, 7.5, z))
    tool.rotation_euler.x = math.pi / 2
    # shortcut: threads are omitted; use the part drawing and real fit before fabrication.
    subtract(standoff, tool)
    standoff.color = (0.55, 0.61, 0.65, 1)
carrier.color = (0.18, 0.22, 0.23, 1)

scene = bpy.context.scene
scene.unit_settings.system = "METRIC"
scene.unit_settings.scale_length = 0.001
scene["status"] = "TRIAL ONLY: no holder body, FFC, wheels, belt, bolts or strength approval"
scene["reference_holes"] = "Small drawing (22.75,32.75)/(42.75,32.75), rotated 90deg so belt runs along X; real fit NOT verified"

bpy.ops.object.camera_add(location=(140, 180, 125))
camera = bpy.context.object
camera.rotation_euler = (Vector((0, 20, 37.5)) - camera.location).to_track_quat("-Z", "Y").to_euler()
camera.data.type = "ORTHO"
camera.data.ortho_scale = 125
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
scene.render.filepath = str(ROOT / "P1_assembly_trial.png")
bpy.ops.wm.save_as_mainfile(filepath=str(ROOT / "P1_assembly_trial.blend"))
bpy.ops.render.render(write_still=True)
print("P1 trial STL, editable assembly and preview generated; no fabrication approval.")

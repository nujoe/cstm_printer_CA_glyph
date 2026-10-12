"""Generate a trial P9 cap and assembly, not a fabrication approval."""

from pathlib import Path
import sys

import bpy
from mathutils import Vector


ROOT = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from cad_geometry import box, bore, subtract

bpy.ops.object.select_all(action="SELECT")
bpy.ops.object.delete(use_global=False)


cap = box("P9_guide_cap_TRIAL", (38, 24, 8), (0, 0, 4))
subtract(cap, box("pipe_clearance_15p4", (38.2, 15.4, 5.2), (0, 0, 2.4)))
subtract(cap, bore("M5_clearance_5p5", 2.75, 10, (0, 0, 4)))
bpy.ops.object.select_all(action="DESELECT")
cap.select_set(True)
bpy.context.view_layer.objects.active = cap
bpy.ops.export_mesh.stl(filepath=str(ROOT / "P9_guide_cap_trial.stl"), use_selection=True)

# The metal plate carries the tube directly; the printed cap sits above it.
plate = box("METAL_plate_60x50x3_NOT_FOR_3D_PRINT", (60, 50, 3), (0, 15, 1.5))
for x, y in ((-15, 0), (15, 0), (0, 17.5)):
    subtract(plate, bore("plate_M5_clearance", 2.75, 5, (x, y, 1.5)))
pipe = box("pipe_15x15_wall_1p5", (70, 15, 15), (0, 17.5, 10.5))
subtract(pipe, box("pipe_inner_12x12", (70.2, 12, 12), (0, 17.5, 10.5)))
subtract(pipe, bore("pipe_M5_clearance", 2.75, 17, (0, 17.5, 10.5)))
spacer = bore("METAL_KNCLM5_8_12_ID5p2_NOMINAL_TRIAL", 4, 12, (0, 17.5, 10.5))
subtract(spacer, bore("spacer_inner", 2.6, 14, (0, 17.5, 10.5)))
spacer["supplier_tolerances_mm"] = "OD7.8..8.0; ID5.1..5.3; L11.9..12.0"
profile = box("2020_ENVELOPE_ONLY_NO_SLOT_GEOMETRY", (70, 20, 20), (0, 0, -10))
cap.location += Vector((0, 17.5, 13))

for obj, color in (
    (cap, (0.85, 0.24, 0.10, 1)),
    (plate, (0.48, 0.53, 0.56, 1)),
    (pipe, (0.72, 0.76, 0.78, 1)),
    (spacer, (0.82, 0.62, 0.20, 1)),
    (profile, (0.17, 0.20, 0.21, 1)),
):
    obj.color = color
    obj["status"] = "trial only; dimensions and hardware require physical checks"

scene = bpy.context.scene
scene.unit_settings.system = "METRIC"
scene.unit_settings.scale_length = 0.001
scene["status"] = "TRIAL ONLY: profile slots, bolts, washers, nuts and strength NOT verified"
scene["plate_holes_mm"] = "(-15,0), (15,0), (0,17.5); diameter 5.5"
bpy.ops.wm.save_as_mainfile(filepath=str(ROOT / "P9_assembly_trial.blend"))
print("P9 trial STL and editable assembly generated; no fabrication approval.")

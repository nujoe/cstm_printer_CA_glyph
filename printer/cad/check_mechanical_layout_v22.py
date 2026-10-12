"""Checks the changed layout interfaces, not the complete machine's safety."""

from pathlib import Path
import unittest
import xml.etree.ElementTree as ET

ROOT = Path(__file__).resolve().parent
NS = {"s": "http://www.w3.org/2000/svg"}


class MechanicalLayoutTests(unittest.TestCase):
    def setUp(self):
        self.svg = ET.parse(ROOT / "mechanical_layout_v22.svg").getroot()

    def test_platen_and_p9_leave_room_for_existing_supports(self):
        frame = self.svg.find(".//s:g[@id='frame-layout']", NS)
        width = float(frame.get("data-platen-width"))
        self.assertGreaterEqual(width, 297)
        post_inner = float(frame.get("data-post-x")) - float(frame.get("data-post-width")) / 2
        self.assertEqual(post_inner - width / 2, 10)
        self.assertLess(post_inner - 360 / 2, 0)
        p9_outer = float(frame.get("data-p9-x")) + float(frame.get("data-p9-plate-width")) / 2
        self.assertAlmostEqual(float(frame.get("data-corner-inner-x")) - p9_outer, 12.2)

    def test_plate_parts_fit_with_cutting_loss(self):
        stock = self.svg.find(".//s:g[@id='stock-sheet']", NS)
        parts = stock.findall(".//s:rect[@data-part]", NS)
        self.assertEqual(len(parts), 6)
        rectangles = []
        for part in parts:
            x, y, w, h = (float(part.get(k)) for k in ("x", "y", "width", "height"))
            self.assertGreaterEqual(min(x, y), 0)
            self.assertLessEqual(x + w, 600)
            self.assertLessEqual(y + h, 400)
            rectangles.append((x, y, x + w, y + h))
        for i, (x0, y0, x1, y1) in enumerate(rectangles):
            for a0, b0, a1, b1 in rectangles[i + 1:]:
                self.assertTrue(x1 + 3 <= a0 or a1 + 3 <= x0 or y1 + 3 <= b0 or b1 + 3 <= y0)

    def test_supply_roll_and_fastener_stack(self):
        roll = self.svg.find(".//s:g[@id='supply-roll']", NS)
        axis = float(roll.get("data-rod-axis"))
        self.assertEqual(axis - float(roll.get("data-roll-max-diameter")) / 2, 15)
        inner = float(roll.get("data-stand-x")) - float(roll.get("data-stand-width")) / 2
        self.assertEqual(inner - 297 / 2 - 2 - 2 * 8, 3.5)
        outer = float(roll.get("data-stand-x")) + float(roll.get("data-stand-width")) / 2
        self.assertEqual(float(roll.get("data-rod-length")) / 2 - outer - 2 - 2 * 8, 12)
        section = self.svg.find(".//s:g[@id='platen-section']", NS)
        self.assertEqual(38 + 33.5 + 3, float(section.get("data-platen-z")))
        self.assertGreaterEqual(float(section.get("data-plate-bolt-length")) - (48.5 + 3 + 0.8 + 3.2), 3)
        self.assertGreaterEqual(float(section.get("data-clamp-bolt-length")) - (40 + 1.6 + 3.2), 3)
        self.assertGreaterEqual(float(section.get("data-base-bolt-length")) - (8 + 3 + 1.6 + 3.2), 3)


if __name__ == "__main__":
    unittest.main()

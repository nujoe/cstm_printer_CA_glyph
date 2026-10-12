"""Check a nominal feed-mount section against original dimensions, not strength."""

from pathlib import Path
import unittest
import xml.etree.ElementTree as ET


ROOT = Path(__file__).resolve().parent
NS = {"s": "http://www.w3.org/2000/svg"}


class FeedMountTrialTests(unittest.TestCase):
    def setUp(self):
        self.svg = ET.parse(ROOT / "feed_mount_trial.svg").getroot()

    def test_through_bolt_stack_and_sleeve(self):
        section = self.svg.find(".//s:g[@id='bolt-section']", NS)
        def span(name):
            rect = section.find(f"s:rect[@id='{name}']", NS)
            return float(rect.get("x")), float(rect.get("width"))
        self.assertEqual(span("p2-base"), (0, 2))
        self.assertEqual(span("pipe-envelope"), (2, 15))
        self.assertEqual(span("pipe-void"), (3.5, 12))
        self.assertEqual(span("p3-body"), (17, 15))
        self.assertEqual(span("crush-sleeve"), span("pipe-void"))
        self.assertEqual(span("bolt-shank"), (-1, 40))
        nut_start, nut_height = span("nut")
        self.assertEqual(nut_start, 33)
        self.assertEqual(nut_height, 3)
        self.assertEqual(-1 + 40 - (nut_start + nut_height), 3)

    def test_upper_rod_clears_blind_ends_and_engages_both_slots(self):
        section = self.svg.find(".//s:g[@id='rod-section']", NS)
        rod = section.find("s:rect[@id='upper-rod']", NS)
        ends = (float(rod.get("x")), float(rod.get("x")) + float(rod.get("width")))
        self.assertEqual(ends, (-200, 200))
        for name, sign in (("left-slot", -1), ("right-slot", 1)):
            slot = section.find(f"s:rect[@id='{name}']", NS)
            x, width = float(slot.get("x")), float(slot.get("width"))
            wall = min(x, x + width) if sign < 0 else max(x, x + width)
            mouth = max(x, x + width) if sign < 0 else min(x, x + width)
            end = ends[0 if sign < 0 else 1]
            self.assertEqual(abs(wall - end), 3)
            self.assertEqual(abs(end - mouth), 10)
        # The former 495 mm blanket cut exceeds the 406 mm blind-end span.
        self.assertGreater(495, 406)

    def test_counts_and_source_dimensions(self):
        counts = self.svg.find(".//s:g[@id='counts']", NS)
        self.assertEqual(int(counts.get("data-supports")), 4)
        self.assertEqual(int(counts.get("data-p3-bolts")), 4 * 2)
        self.assertEqual(int(counts.get("data-p2-bolts")), 4 * 2)
        self.assertEqual(int(counts.get("data-sleeves")), 4 * 2 * 2)
        source = (ROOT.parent / "reference/worldprinter/WorldPrinter.scad").read_text()
        p3 = source.split("module top_roller_mount(", 1)[1].split("module belt_mount", 1)[0]
        for text in ("trm_h = 15", "trm_wall = 2", "trm_gap = 10.2", "7.5"):
            self.assertIn(text, p3)
        self.assertIn("NOT AN ORDER APPROVAL", " ".join(self.svg.itertext()))

    def test_low_frame_uses_raised_guide_for_upper_bearing(self):
        heights = self.svg.find(".//s:g[@id='feed-height']", NS)
        self.assertIsNotNone(heights)
        lower = float(heights.get("data-lower-rod-z"))
        upper = float(heights.get("data-upper-rod-z"))
        r_lower = float(heights.get("data-covered-roller-radius"))
        r_upper = float(heights.get("data-contact-bearing-radius"))
        self.assertEqual(lower + r_lower, upper - r_upper)
        offset = float(heights.get("data-guide-local-to-world-z"))
        self.assertEqual(upper - offset, 51)
        self.assertGreater(upper - offset - 5, float(heights.get("data-slot-start")))
        self.assertLess(upper - offset + 5, float(heights.get("data-slot-end")))


if __name__ == "__main__":
    unittest.main()

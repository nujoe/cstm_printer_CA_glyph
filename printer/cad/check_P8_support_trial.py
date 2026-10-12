"""Check the nominal P8 layout, not slot fit, strength or hardware approval."""

from pathlib import Path
import unittest
import xml.etree.ElementTree as ET


ROOT = Path(__file__).resolve().parent


class P8SupportTrialTests(unittest.TestCase):
    def test_posts_and_foot_brackets_clear_inner_pipe_frame(self):
        root = ET.parse(ROOT / "P8_support_trial.svg").getroot()
        ns = {"s": "http://www.w3.org/2000/svg"}
        front = root.find(".//s:g[@id='front-layout']", ns)
        ox = float(front.get("data-origin-x"))
        # The 440-wide tube frame has its inner faces at +/-205.
        for name in ("front-left-post", "front-right-post"):
            post = root.find(f".//s:rect[@id='{name}']", ns)
            centre = abs(float(post.get("x")) + float(post.get("width")) / 2 - ox)
            outer_foot_edge = centre + float(post.get("width")) / 2 + 20
            self.assertLessEqual(outer_foot_edge, 200, "Post/foot bracket conflicts with tube at X205..220")

    def test_small_gantry_uses_20mm_face_and_single_rear_slot(self):
        root = ET.parse(ROOT / "P8_support_trial.svg").getroot()
        ns = {"s": "http://www.w3.org/2000/svg"}
        rail = root.find(".//s:rect[@id='front-rail']", ns)
        self.assertEqual(float(rail.get("height")), 20)
        front = root.find(".//s:g[@id='front-layout']", ns)
        slot_z = float(front.get("data-origin-y")) - float(rail.get("y")) - 10
        holes = root.findall(".//s:circle[@data-part='rail-hole']", ns)
        self.assertEqual({float(h.get("data-z")) for h in holes}, {slot_z})
        for centre in (-170, 170):
            self.assertEqual(
                sorted(float(h.get("data-x")) - centre for h in holes
                       if abs(float(h.get("data-x")) - centre) < 40),
                [-20, 20],
            )
        side = root.find(".//s:g[@id='side-layout']", ns)
        side_rail = side.find("s:rect[@id='side-rail']", ns)
        side_post = side.find("s:rect[@id='side-post']", ns)
        scale = float(side.get("data-y-scale"))
        self.assertEqual(float(side_rail.get("width")) / scale, 40)
        self.assertEqual(float(side_rail.get("height")), 20)
        self.assertEqual(float(side_rail.get("y")), float(rail.get("y")))
        gap = (float(side_post.get("x")) - float(side_rail.get("x"))
               - float(side_rail.get("width"))) / scale
        self.assertEqual(gap, 5)

    def test_stock_counts_and_nominal_clearances(self):
        path = ROOT / "P8_support_trial.svg"
        self.assertTrue(path.is_file(), "Missing P8 support drawing")
        root = ET.parse(path).getroot()
        ns = {"s": "http://www.w3.org/2000/svg"}
        parts = {node.get("id"): node for node in root.findall(".//s:g[@data-qty]", ns)}
        self.assertEqual(
            {key: int(node.get("data-qty")) for key, node in parts.items()},
            {"crossbeam": 1, "posts": 2, "bracket-sets": 12, "rail-nuts": 4},
        )
        self.assertEqual(parts["crossbeam"].get("data-mm"), "560,20,20")
        self.assertEqual(parts["posts"].get("data-mm"), "20,20,150")
        front = root.find(".//s:g[@id='front-layout']", ns)
        ox, oz = float(front.get("data-origin-x")), float(front.get("data-origin-y"))
        beam = root.find(".//s:rect[@id='front-crossbeam']", ns)
        self.assertEqual(float(root.get("data-base-width")) - 2 * 20, float(beam.get("width")))
        post_x = []
        for name in ("front-left-post", "front-right-post"):
            node = root.find(f".//s:rect[@id='{name}']", ns)
            self.assertEqual((float(node.get("width")), float(node.get("height"))), (20, 150))
            self.assertEqual(float(node.get("y")) + float(node.get("height")), float(beam.get("y")))
            post_x.append(float(node.get("x")) + 10 - ox)
        self.assertEqual(post_x, [-170, 170])
        self.assertGreater(min(abs(x) - 10 for x in post_x), float(root.get("data-paper-width")) / 2)
        self.assertEqual(float(root.get("data-post-front-y")) - float(root.get("data-rail-rear-y")), 5)
        holes = root.findall(".//s:circle[@data-part='rail-hole']", ns)
        actual = {(float(h.get("data-x")), float(h.get("data-z"))) for h in holes}
        self.assertEqual(actual, {(-190, 90), (-150, 90), (150, 90), (190, 90)})
        self.assertEqual(len(holes), 4)
        for h in holes:
            self.assertEqual(float(h.get("data-diameter")), 5.5)
            self.assertEqual(float(h.get("cx")) - ox, float(h.get("data-x")))
            self.assertEqual(oz - float(h.get("cy")), float(h.get("data-z")))
        self.assertEqual(int(parts["rail-nuts"].get("data-buy-qty")), 10)
        self.assertEqual(parts["bracket-sets"].get("data-model"), "HBLSS5-SET")
        self.assertEqual(parts["bracket-sets"].get("data-unit-net-krw"), "1912")
        self.assertEqual(parts["bracket-sets"].get("data-quote-vat-krw"), "25238")
        self.assertEqual(1912 * 12 * 110 // 100, 25238)
        text = " ".join(root.itertext())
        self.assertIn("NOT AN ORDER APPROVAL", text)
        self.assertIn("V-wheels, motor, nozzle and real slot fit NOT modelled", text)


if __name__ == "__main__":
    unittest.main()

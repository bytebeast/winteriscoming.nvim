#!/usr/bin/env python3
"""Build README images from raw screenshots and the Lua palettes.

usage: make_assets.py --shots DIR [--out images] [--font-dir DIR]

Produces:
  images/screenshots/*.png  copies of the framed screenshots
  images/styles.png         the three styles side by side
  images/palette.png        swatch sheet from the colors the plugin resolves
"""
import argparse
import json
import os
import subprocess

from PIL import Image, ImageDraw, ImageFont

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
STYLES = ["blue", "black", "light"]
BASES = ["bg_darker", "bg_dark", "bg", "bg_highlight", "bg_widget", "bg_visual", "fg_muted", "comment", "fg_dark", "fg"]
ACCENTS = ["ice", "blue", "periwinkle", "mist", "violet", "lavender", "cream", "mint", "green", "teal", "purple", "ember", "red", "amber"]
SHOTS = ["hero", "picker", "hover-light", "dashboard"]

# colors() runs the same resolution as the colorscheme (on_colors, faithful,
# role aliases), so the sheet can't drift from what Neovim shows
EXPORT = """
local out = {}
for _, s in ipairs({ "blue", "black", "light" }) do
  out[s] = require("winteriscoming").colors({ style = s })
end
io.write(vim.json.encode(out))
"""


def palettes():
    res = subprocess.run(
        ["nvim", "--headless", "--clean", "-u", "NONE", "--cmd", "set rtp^=" + ROOT, "-l", "-"],
        input=EXPORT, capture_output=True, text=True, check=True,
    )
    return json.loads(res.stdout)


def rgb(h):
    return tuple(int(h[i : i + 2], 16) for i in (1, 3, 5))


def fonts(font_dir):
    return lambda name, size: ImageFont.truetype(os.path.join(font_dir, f"JetBrainsMonoNerdFontMono-{name}.ttf"), size)


def palette_sheet(pal, font, out):
    sw, sh, pad, label_w, gap, row_h = 86, 46, 28, 150, 26, 112
    W = pad * 2 + label_w + (len(BASES) + len(ACCENTS)) * sw + gap
    H = pad * 2 + len(STYLES) * row_h - 12
    img = Image.new("RGB", (W, H), (10, 12, 18))
    d = ImageDraw.Draw(img)
    big, small = font("Bold", 21), font("Regular", 11)
    for r, style in enumerate(STYLES):
        p = pal[style]
        y = pad + r * row_h
        d.rounded_rectangle([pad - 12, y - 12, W - pad + 12, y + row_h - 24], radius=10, fill=rgb(p["bg"]), outline=rgb(p["border"]))
        d.text((pad + 2, y + sh // 2 - 14), style, font=big, fill=rgb(p["fg"]))
        x = pad + label_w
        for i, key in enumerate(BASES + ACCENTS):
            if i == len(BASES):
                x += gap
            c = p[key]
            d.rounded_rectangle([x + 3, y, x + sw - 3, y + sh], radius=6, fill=rgb(c), outline=rgb(p["border"]))
            d.text((x + 4, y + sh + 6), key, font=small, fill=rgb(p["fg_dark"]))
            d.text((x + 4, y + sh + 21), c[1:], font=small, fill=rgb(p["fg_muted"]))
            x += sw
    img.save(out, optimize=True)


def styles_grid(shots, out):
    imgs = [Image.open(os.path.join(shots, f"style-{s}.png")).convert("RGB") for s in STYLES]
    w, h = imgs[0].size
    sw, sh = w // 2, h // 2
    grid = Image.new("RGB", (sw * len(imgs), sh), (14, 14, 20))
    for i, im in enumerate(imgs):
        grid.paste(im.resize((sw, sh), Image.LANCZOS), (i * sw, 0))
    grid.save(out, optimize=True)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--shots", required=True)
    ap.add_argument("--out", default=os.path.join(ROOT, "images"))
    ap.add_argument("--font-dir", default=os.environ.get("WIC_FONT_DIR"),
                    help="folder with JetBrainsMonoNerdFontMono-*.ttf (or set WIC_FONT_DIR)")
    a = ap.parse_args()

    os.makedirs(os.path.join(a.out, "screenshots"), exist_ok=True)
    palette_sheet(palettes(), fonts(a.font_dir), os.path.join(a.out, "palette.png"))
    styles_grid(a.shots, os.path.join(a.out, "styles.png"))
    for name in SHOTS:
        Image.open(os.path.join(a.shots, name + ".png")).save(os.path.join(a.out, "screenshots", name + ".png"), optimize=True)
    print("wrote", a.out)


if __name__ == "__main__":
    main()

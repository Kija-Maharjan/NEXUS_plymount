#!/usr/bin/env python3
# ─────────────────────────────────────────────
#  NEXUS AI — Plymouth Asset Generator
#  Generates splash.png and progress frames
#  Run: python3 generate_assets.py
# ─────────────────────────────────────────────

from PIL import Image, ImageDraw, ImageFont
import os, sys

OUT = os.path.dirname(os.path.abspath(__file__))
W, H = 1920, 1080

BLUE   = (126, 200, 240)
PURPLE = (106,  61, 232)
WHITE  = (255, 255, 255)
BLACK  = (  0,   0,   0)

def get_font(size):
    paths = [
        "/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf",
        "/usr/share/fonts/truetype/liberation/LiberationSans-Bold.ttf",
        "/usr/share/fonts/truetype/noto/NotoSans-Bold.ttf",
        "/usr/share/fonts/truetype/noto/NotoSans-Regular.ttf",
    ]
    for p in paths:
        if os.path.exists(p):
            try:
                return ImageFont.truetype(p, size)
            except:
                continue
    print("Warning: No bold font found, using default")
    return ImageFont.load_default()

# ── SPLASH BACKGROUND ──
print("Generating splash.png...")
img  = Image.new("RGB", (W, H), BLACK)
draw = ImageDraw.Draw(img)

# Purple radial glow center
for r in range(380, 0, -1):
    alpha = int(22 * (1 - r/380))
    col = (int(PURPLE[0]*alpha/255), int(PURPLE[1]*alpha/255), int(PURPLE[2]*alpha/255))
    draw.ellipse([W//2-r, H//2-r+20, W//2+r, H//2+r+20], fill=col)

# Blue glow bottom left
for r in range(180, 0, -1):
    alpha = int(10 * (1 - r/180))
    col = (int(BLUE[0]*alpha/255), int(BLUE[1]*alpha/255), int(BLUE[2]*alpha/255))
    draw.ellipse([100-r, H-150-r, 100+r, H-150+r], fill=col)

# Corner accents
c = (55, 80, 120)
s = 32; m = 22
draw.line([(m,m),(m+s,m)], fill=c, width=1)
draw.line([(m,m),(m,m+s)], fill=c, width=1)
draw.line([(W-m,m),(W-m-s,m)], fill=c, width=1)
draw.line([(W-m,m),(W-m,m+s)], fill=c, width=1)
draw.line([(m,H-m),(m+s,H-m)], fill=c, width=1)
draw.line([(m,H-m),(m,H-m-s)], fill=c, width=1)
draw.line([(W-m,H-m),(W-m-s,H-m)], fill=c, width=1)
draw.line([(W-m,H-m),(W-m,H-m-s)], fill=c, width=1)

# NEXUS text — NEX white, US blue
font_big = get_font(100)
letters  = ['N','E','X','U','S']
colors   = [WHITE, WHITE, WHITE, BLUE, BLUE]
widths   = []
for l in letters:
    bb = font_big.getbbox(l)
    widths.append(bb[2] - bb[0])

spacing = 10
total_w = sum(widths) + spacing * (len(letters)-1)
sx      = W//2 - total_w//2
cy      = H//2 - 20

x = sx
for letter, color, w in zip(letters, colors, widths):
    bb = font_big.getbbox(letter)
    draw.text((x - bb[0], cy - bb[3]//2), letter, font=font_big, fill=color)
    x += w + spacing

# Subtle dot divider below text
for dx in range(-50, 51, 14):
    alpha = max(0, 100 - abs(dx)*2)
    draw.ellipse([W//2+dx-1, cy+72, W//2+dx+1, cy+74], fill=(126,200,240))

img.save(f"{OUT}/splash.png")
print("✓ splash.png done")

# ── PROGRESS BAR FRAMES ──
FRAMES = 22
BAR_W  = 220
BAR_H  = 20
bw     = 200

print(f"Generating {FRAMES} progress frames...")
for i in range(FRAMES):
    frame = Image.new("RGBA", (BAR_W, BAR_H), (0,0,0,0))
    d     = ImageDraw.Draw(frame)
    phase = i / FRAMES

    if phase < 0.5:
        fw = int(bw * (phase/0.5) * 0.70)
        fx = 0
    elif phase < 0.8:
        t  = (phase-0.5)/0.3
        fw = int(bw * (0.70 - t*0.50))
        fx = int(bw * t * 0.80)
    else:
        t  = (phase-0.8)/0.2
        fw = int(bw * 0.20 * (1-t))
        fx = int(bw * (0.80 + t*0.20))

    # Track
    d.rectangle([10, 9, 10+bw, 11], fill=(25,25,35,200))

    # Gradient sweep bar
    if fw > 0:
        for px in range(fw):
            t2 = px / bw
            r  = int(BLUE[0]+(PURPLE[0]-BLUE[0])*t2)
            g  = int(BLUE[1]+(PURPLE[1]-BLUE[1])*t2)
            b  = int(BLUE[2]+(PURPLE[2]-BLUE[2])*t2)
            d.line([(10+fx+px, 9),(10+fx+px, 11)],  fill=(r,g,b,255))
            d.line([(10+fx+px, 8),(10+fx+px, 8)],   fill=(r,g,b,70))
            d.line([(10+fx+px, 12),(10+fx+px, 12)], fill=(r,g,b,70))

    frame.save(f"{OUT}/progress_{i:04d}.png")

print(f"✓ {FRAMES} progress frames done")
print("\n✓ All assets generated! Run install.sh to install.")

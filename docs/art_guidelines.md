# Art Guidelines

This project is configured for a **Retro Pixel Art** aesthetic.

## 📐 Project Resolution
*   **Viewport Size**: `320 x 180` pixels.
*   **Aspect Ratio**: 16:9.
*   **Stretch Mode**: `viewport` (The game renders at 320x180 and is then scaled up to the screen size).

## 🎨 Asset Creation Strategies

### Option A: Pixel Art (Recommended)
This is the native style for this resolution.
*   **Grid Size**: A 16x16 or 32x32 grid works best.
*   **Character Size**: Typically ~16-24 pixels tall for "Game Boy" style, or 32px for "GBA/SNES" style.
*   **Tools**: Aseprite, Libresprite, Piskel, or Photoshop (pencil tool).
*   **Export**: Export as `.png`. Do not upscale during export (keep it small, e.g., 16px).

### Option B: Vector Art / Illustrator
You can use Adobe Illustrator, Figma, or Inkscape, but you must be careful with export sizes because our game world is very "small" (320px wide).

**Workflow**:
1.  Design your character/object in Illustrator.
2.  **Export Size**: Export as a PNG where the asset height corresponds to its in-game size (e.g., export the character to be **16px to 32px tall**).
3.  **Do NOT** export a 1000px high-res image and shrink it in Godot.
    *   *Why?* Godot will downscale it to fit the 180px high screen, making it look blurry or pixelated in a messy way.
4.  **Anti-aliasing**:
    *   If you want a "clean vector" look: Export with anti-aliasing ON. It will look like a smooth, tiny sprite.
    *   If you want a "pixel" look: Turn anti-aliasing OFF during export.

## 📥 Godot Import Settings

The project is set to **Nearest Neighbor** filtering by default.

### For Pixel Art (Crisp)
*   **Settings**: Default is fine.
*   **Check**: Select the file in Godot, go to the **Import** tab. Ensure `Filter` is `Nearest`.

### For Smooth/Vector Art
If you opted for "Option B" with anti-aliasing, the "Nearest" filter might make the edges look "crunchy."
1.  Select the `.png` in the FileSystem dock.
2.  Go to the **Import** tab (top left dock).
3.  Change **Texture > Filter** to `Linear` (or `Linear Mipmap`).
4.  Click **Reimport**.
*Note: Mixing "Nearest" items (backgrounds) with "Linear" items (characters) can sometimes look jarring, so try to stick to one style.*

## 📂 Folder Structure
Organize `res://art/` to keep things tidy:
*   `art/characters/`
*   `art/environment/` (tilesets, trees)
*   `art/ui/` (dialogue boxes, icons)

## 🏃 Animation & Sprite Sheets

Yes! **Sprite Sheets** are the standard way to handle animations in Godot.

### Aseprite Workflow
Aseprite is perfect for this.
1.  **Create your animation** on the timeline (e.g., Frames 1-4 are Walk Down, Frames 5-8 are Walk Up).
2.  **Exporting**:
    *   Go to `File > Export Sprite Sheet`.
    *   **Layout**: `Packed` or `By Rows`.
    *   **Sheet Type**: `Horizontal Strip` (all frames in one long row) OR `Grid` (Rows = Directions, Columns = Animation Frames).
    *   **Trim**: OFF (Keep purely grid-based to make setup easier in Godot).

### Recommended Layout (4-Direction Walk)
For a top-down character, a common standard is:
*   **Row 1**: Walk Down (North)
*   **Row 2**: Walk Right (East)
*   **Row 3**: Walk Up (South)
*   **Row 4**: Walk Left (West)
*(Or typically: Down, Up, Left, Right - just be consistent!)*

### Setting it up in Godot
You will use a `Sprite2D` node.
1.  Load your sprite sheet into the `Texture` property.
2.  Expand the **Animation** section in the Inspector.
3.  Set **Hframes**: Number of columns (horizontal frames).
4.  Set **Vframes**: Number of rows (vertical frames).
5.  Changing the **Frame** property will now cycle through your animations!


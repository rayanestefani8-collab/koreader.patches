# KOReader Patch: Hide Title Bar

A patch for KOReader that hides the title bar in the File Manager/Browser, allowing the cover grid to fill the entire screen.

## ✨ Features
* Removes the top bar (title + menu) in FileManager.
* The freed space is used by the cover grid.
* **Fix:** Keeps the close buttons (X) visible in popups and settings menus.

## 🚀 How to Install
1. Download the `2-hide-titlebar-filebrowser.lua` file from this repository.
2. Connect your e-reader to your computer.
3. Copy the file to the `koreader/patches/` folder on the device’s storage.
4. Restart KOReader.

## ⚠️ Notes
* Navigation between folders still works via gestures or long-pressing on empty spaces.
* Tested on Kindle devices with KOReader 2025.04+.
* Enable gesture navigation before applying the patch: [Link to the patch](https://github.com/rayanestefani8-collab/koreader-patches/blob/main/2-hide-titlebar-filebrowser.lua)

# KOReader ImageViewer Screenshot Patch

A user patch for [KOReader](https://github.com/koreader/koreader) that adds a **Screenshot** button to the ImageViewer toolbar.

## The Problem

KOReader's ImageViewer intercepts all touch input for zoom and pan. This blocks both:

- Custom gestures configured in the Gestures plugin
- The built-in diagonal tap gesture (`two_finger_tap`)

The result: there is no reliable way to take a screenshot while viewing an image in fullscreen mode.

This is a known issue tracked in [#6699](https://github.com/koreader/koreader/issues/6699).

## The Solution

This patch injects a **Screenshot** button as the first item in the ImageViewer button bar — the toolbar that appears when you tap the screen.

The button calls KOReader's native `onSaveImageView()`, which:

1. Temporarily hides the UI (title bar + buttons)
2. Forces a clean screen repaint
3. Captures the screen via the standard `Screenshoter` system
4. Shows the **native screenshot menu** (set as wallpaper, etc.)
5. Restores the ImageViewer UI

The result is identical to what a working diagonal tap would produce.

## Install

1. Connect your device to a PC
2. Copy `2-imageviewer-screenshot.lua` to:
   ```
   KOBOeReader/.adds/koreader/patches/
   ```
   > **Note:** `.adds` is a hidden folder. Enable "Show hidden files" in your file manager.
3. Restart KOReader

The Screenshot button will appear as the first button in the ImageViewer toolbar.

## Tested On

| Device | KOReader Version |
|---|---|
| Kobo Libra Color | v2026.03 |

## Technical Notes

This patch intentionally avoids using `_()` (KOReader's gettext function) for the button label. During priority-2 patch loading, other patches may overwrite the `_` global with a non-function value, causing a runtime crash. Using a plain string avoids this conflict entirely.

## License

## Credits

Developed with assistance from [Claude](https://claude.ai) (Anthropic).

MIT

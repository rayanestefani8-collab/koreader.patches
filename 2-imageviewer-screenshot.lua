-- 2-imageviewer-screenshot.lua

local ok_iv, ImageViewer = pcall(require, "ui/widget/imageviewer")
if not ok_iv then return end
if ImageViewer._patched_screenshot then return end
ImageViewer._patched_screenshot = true

local orig_init = ImageViewer.init

ImageViewer.init = function(self, ...)
    orig_init(self, ...)
    -- Insere botão Screenshot como primeiro botão da barra
    table.insert(self.button_table.buttons[1], 1, {
        id = "screenshot",
        text = "Screenshot",  -- sem _() para evitar conflito
        callback = function()
            self:onSaveImageView()
        end,
    })
end

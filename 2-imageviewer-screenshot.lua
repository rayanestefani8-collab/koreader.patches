local ok_bt, ButtonTable = pcall(require, "ui/widget/buttontable")
if not ok_bt then return end
if ButtonTable._patched_imageviewer_screenshot then return end
ButtonTable._patched_imageviewer_screenshot = true

-- ImageViewer sempre constrói seu self.button_table (linha "scale"/"rotate"/
-- "close") dentro de ImageViewer:init(), e o layout desses botões é montado
-- dentro de ButtonTable:init(), usando self.buttons. Inserir um botão DEPOIS
-- que o ButtonTable já foi construído (como o patch antigo fazia) não tem
-- efeito visual, pois o layout já foi calculado. Por isso interceptamos
-- ButtonTable:init() e inserimos nosso botão de Screenshot na primeira
-- linha (self.buttons[1]) ANTES do layout ser montado -- mas só quando essa
-- linha é, de fato, a do ImageViewer (identificada pela assinatura única de
-- ids "scale"/"rotate"/"close"), pra não afetar nenhum outro widget do
-- KOReader que também usa ButtonTable.
local orig_init = ButtonTable.init
ButtonTable.init = function(self, ...)
    local row = self.buttons and self.buttons[1]
    local is_imageviewer_row = row
        and row[1] and row[1].id == "scale"
        and row[2] and row[2].id == "rotate"
        and row[3] and row[3].id == "close"

    if is_imageviewer_row and not self._screenshot_button_added then
        self._screenshot_button_added = true
        local viewer = self.show_parent
        table.insert(row, 1, {
            id = "screenshot",
            text = "Screenshot",  -- sem _() para evitar conflito
            callback = function()
                if viewer and viewer.onSaveImageView then
                    viewer:onSaveImageView()
                end
            end,
        })
    end

    orig_init(self, ...)
end

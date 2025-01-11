local M = {}

function M.setup()
    local colors = {
        -- Basic colors (from your Cursor theme)
        bg = "#24202c",
        fg = "#f4cde9",
        selection_bg = "#f4cde9",
        selection_fg = "#24202c",
        
        -- Terminal colors (from your Cursor theme)
        black = "#464646",
        black2 = "#6c6c6c",
        red = "#e9897c",
        red2 = "#f99286",
        green = "#b6377d",
        green2 = "#c3f786",
        yellow = "#ecebbe",
        yellow2 = "#fcfbcc",
        blue = "#a9cdeb",
        blue2 = "#b6defb",
        magenta = "#75507b",
        magenta2 = "#ad7fa8",
        cyan = "#c9caec",
        cyan2 = "#d7d9fc",
        white = "#f2f2f2",
        white2 = "#e2e2e2",

        -- UI colors from your Cursor theme
        border_active = "#b7bdf8",
        border_inactive = "#6e738d",
        bell = "#eed49f",
    }

    -- Reset highlighting
    vim.cmd("hi clear")
    if vim.fn.exists("syntax_on") then
        vim.cmd("syntax reset")
    end

    vim.g.colors_name = "vitaale"

    local highlight = function(group, opts)
        vim.api.nvim_set_hl(0, group, opts)
    end

    -- Editor highlights (matched to your Cursor theme)
    highlight("Normal", { fg = colors.fg, bg = colors.bg })
    highlight("CursorLine", { bg = colors.black })
    highlight("CursorLineNr", { fg = colors.red2 })  -- Using accent color from your theme
    highlight("LineNr", { fg = colors.black2 })
    highlight("SignColumn", { bg = colors.bg })
    highlight("VertSplit", { fg = colors.border_inactive })
    highlight("StatusLine", { fg = colors.fg, bg = colors.black })
    highlight("StatusLineNC", { fg = colors.border_inactive, bg = colors.black })
    highlight("Search", { fg = colors.selection_fg, bg = colors.selection_bg })
    highlight("IncSearch", { fg = colors.selection_fg, bg = colors.red2 })
    highlight("Visual", { fg = colors.selection_fg, bg = colors.selection_bg })
    highlight("WinSeparator", { fg = colors.border_inactive })
    highlight("FloatBorder", { fg = colors.border_active })

    -- Syntax highlighting (matched to your Cursor theme's token colors)
    highlight("Comment", { fg = colors.black2, italic = true })
    highlight("Constant", { fg = colors.red2 })
    highlight("String", { fg = colors.green })
    highlight("Character", { fg = colors.green })
    highlight("Number", { fg = colors.yellow })
    highlight("Boolean", { fg = colors.red2 })
    highlight("Float", { fg = colors.yellow })
    highlight("Identifier", { fg = colors.blue })
    highlight("Function", { fg = colors.blue })
    highlight("Statement", { fg = colors.red })
    highlight("Keyword", { fg = colors.red2 })
    highlight("PreProc", { fg = colors.magenta })
    highlight("Type", { fg = colors.yellow })
    highlight("Special", { fg = colors.cyan })
    highlight("Error", { fg = colors.red })
    highlight("Todo", { fg = colors.yellow2, bold = true })

    -- Additional UI elements (matched to your Cursor theme)
    highlight("Pmenu", { fg = colors.fg, bg = colors.black })
    highlight("PmenuSel", { fg = colors.selection_fg, bg = colors.selection_bg })
    highlight("PmenuSbar", { bg = colors.black2 })
    highlight("PmenuThumb", { bg = colors.border_active })
    highlight("Directory", { fg = colors.blue })
    highlight("Title", { fg = colors.red2, bold = true })
    highlight("WarningMsg", { fg = colors.yellow })
    highlight("ErrorMsg", { fg = colors.red })
    highlight("SpecialKey", { fg = colors.cyan })
    highlight("NonText", { fg = colors.black2 })
end

return M 
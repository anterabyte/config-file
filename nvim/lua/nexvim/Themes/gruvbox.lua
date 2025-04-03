

local global = vim.g
local cmd = vim.cmd

-- GruvBox-baby
--
global.gruvbox_baby_function_style = "NONE"
global.gruvbox_baby_keyword_style = "italic"
global.gruvbox_baby_comment_style = "NONE"

-- Each highlight group must follow the structure:
-- ColorGroup = {fg = "foreground color", bg = "background_color", style = "some_style(:h attr-list)"}
-- See also :h highlight-guifg
-- Example:
global.gruvbox_baby_highlights = {Normal = {fg = "#EFF4F2", bg = "NONE", style="underline"}}

-- Enable telescope theme
global.gruvbox_baby_telescope_theme = 1

-- Enable transparent mode
global.gruvbox_baby_transparent_mode = 1
cmd 'colorscheme gruvbox-baby'
--]]

local cmd = vim.cmd
local set = vim.o


require("nexvim.lazy")
require("nexvim.keymap")

-- Transparent Background
cmd [[
  highlight Normal guibg=none
  highlight NonText guibg=none
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
]]


-- Set Intial Options for Nvim
set.number = true
set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 0
set.expandtab = true
set.swapfile = false
set.signcolumn = "yes"
set.smartcase = true
set.smartindent = true




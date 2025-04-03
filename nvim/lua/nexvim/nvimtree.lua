--[[

oooo   oooo ooooo  oooo ooooo oooo     oooo ooooooooooo oooooooooo  ooooooooooo ooooooooooo 
 8888o  88   888    88   888   8888o   888  88  888  88  888    888  888    88   888    88  
 88 888o88    888  88    888   88 888o8 88      888      888oooo88   888ooo8     888ooo8    
 88   8888     88888     888   88  888  88      888      888  88o    888    oo   888    oo  
o88o    88      888     o888o o88o  8  o88o    o888o    o888o  88o8 o888ooo8888 o888ooo8888 
                                                                                            

--]]


local global = vim.g

local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent,        opts('Up'))
  vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))
end


-- Nvim-tree
-- disable netrw at the very start of your init.lua (strongly advised)
global.loaded_netrw = 1
global.loaded_netrwPlugin = 1

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
  on_attach=my_on_attach,
})

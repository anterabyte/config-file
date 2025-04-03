local global = vim.g
local keymap = vim.api.nvim_set_keymap

global.mapleader = " "

keymap('n', '<leader>w', ':w<CR>',{noremap = true})
keymap('i', '<C-s>',     '<CMD>:w<CR>',{noremap = true})
keymap('n', '<leader>q', ':q!<CR>',{noremap = true})
keymap('n', '<leader>s', ':so %<CR>',{noremap = true})
keymap('n', '<leader>ev', ':vsplit $MYVIMRC<CR>',{noremap = true})
keymap('n', '<leader>b', ':Neotree toggle<CR>',{noremap = true})

--move around diffrent panes
keymap('n', '<A-h>', '<C-w>h',{noremap = true})
keymap('n', '<A-j>', '<C-w>j',{noremap = true})
keymap('n', '<A-k>', '<C-w>k',{noremap = true})
keymap('n', '<A-l>', '<C-w>l',{noremap = true})

--split screen
keymap('n', '<leader>h', '<C-w>s',{noremap = true})
keymap('n', '<leader>v', '<C-w>v',{noremap = true})

-- resize pane
keymap('n', '<leader><Left>', ':vertical resize -10<CR>',{noremap = true})
keymap('n', '<leader><Right>',':vertical resize +10<CR>',{noremap = true})
keymap('n', '<leader><Up>',   ':resize +10<CR>',{noremap = true})
keymap('n', '<leader><Down>', ':resize -10<CR>',{noremap = true})
keymap('n', '<leader>d', ':nohl<CR>',{noremap = true})

-- terminal and Floaterm
keymap('t', '<esc>', '<C-\\><C-n>',{noremap = true})
keymap('n', '<C-n>', ':FloatermToggle<CR>', {noremap = true})
keymap('n', '<leader>n', ':FloatermNew --height=0.5 --width=1.0 --position=bottomright --wintype=float<CR>', {noremap = true})
keymap('n', '<leader>N', ':FloatermNew --height=1.0 --width=1.0 --position=topright --wintype=float<CR>', {noremap = true})
keymap('n', '<leader>l', ':FloatermNew --height=1.0 --width=0.6 --position=topright --wintype=float<CR>', {noremap = true})


-- move between panes
keymap('n', '<tab>', '<C-w><C-w>', {noremap = true})
keymap('n', '<leader>a', ':vsplit new-file<CR>', {noremap = true})

-- Fugitive
keymap('n', '<leader>f', ':Git fetch upstream<CR>', {noremap = true})
keymap('n', '<leader>m', ':Git merge upstream/main<CR>', {noremap = true})
keymap('n', '<C-a>'    , ':Git status<CR>', {noremap = true})
keymap('n', '<leader>A', ':Git add -A<CR>', {noremap = true})
keymap('n', '<leader>C', ':Git commit<CR>', {noremap = true})

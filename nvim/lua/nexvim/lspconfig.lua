--[[
██╗     ███████╗██████╗  ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗ 
██║     ██╔════╝██╔══██╗██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝ 
██║     ███████╗██████╔╝██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗
██║     ╚════██║██╔═══╝ ██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║
███████╗███████║██║     ╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝
╚══════╝╚══════╝╚═╝      ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝ 
                                                                       
--]]

-- LSP and Code Completion

-- Using COC 

--cmd "let g:coc_global_extension = [ 'coc-emmet', 'coc-go', 'coc-html', 'coc-eslint', 'coc-git', 'coc-json', 'coc-pyright', 'coc-tsserver', 'coc-prettier', 'coc-yaml']"

-- [[Using native builtin packages
--[[ 
vim.lsp.start_client(
{
  name = 'myserver1',
  cmd = {'gopls'},
  root_dir = vim.fs.dirname(vim.fs.find({'go.mod', '*.go'}, { upward = true })[1]),
},
{
    name = 'myserver2',
    cmd = {'pyright'},
    root_dir = vim.fs.dirname(vim.fs.find({'*.py'}, { upward = true })[1]),
}
)
--]]


-- LSP using LSP-config

local lspconfig = require('lspconfig')
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local luasnip = require 'luasnip'
local cmp = require 'cmp'


-- for python
lspconfig.pyright.setup {

    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    -- root_dir: see source file,
    settings = {
            python = {
            analysis = {
            autoSearchPaths = true,
            diagnosticMode = "openFilesOnly",
            useLibraryCodeForTypes = true
            }
        }
    },
    single_file_support = true
}

-- for golang
lspconfig.gopls.setup {

    cmd = {"gopls"},
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    -- root_dir = root_pattern("go.work", "go.mod", ".git"),
    single_file_support = true,
}


local servers = {
    "pyright",
    "gopls",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
  }
end

cmp.setup {
    snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      sources = {
        { name = 'nvim_lsp' },
        {name = "buffer"},
      },
            mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
        ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
      }),
}

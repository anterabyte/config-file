--[[

██╗     ██╗   ██╗ █████╗ ██╗     ██╗███╗   ██╗███████╗
██║     ██║   ██║██╔══██╗██║     ██║████╗  ██║██╔════╝
██║     ██║   ██║███████║██║     ██║██╔██╗ ██║█████╗  
██║     ██║   ██║██╔══██║██║     ██║██║╚██╗██║██╔══╝  
███████╗╚██████╔╝██║  ██║███████╗██║██║ ╚████║███████╗
╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝╚═╝  ╚═══╝╚══════╝

--]]


-- lualine setup

local lualine  = require('lualine')

local colors = {
    blue ='#0723f2',
    --black = '#040808',
    bg = '#202328',
    fg = '#f0f5f5',
    red = '#f20707',
    violet = '#e505ed',
    grey = '#4f4d4f',
    cyan = '#11d6f5',
    orange = '#f25c05',
    yellow = '#eef205',
    green = '#64f205',
    magenta = '#dd0a9e',
}

local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
    end,
    hide_in_width =  function()
        return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
        local filepath = vim.fn.expand('%:p:h')
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
}



local config = {
    options = {
        theme = {
            normal = { c = { fg = colors.fg, bg = colors.bg}},
            inactive = { c = { fg = colors.fg, bg = colors.bg}}
        },
        component_separators = '',
        section_separators = '',
    },

    sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },

    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_y = {},
        lualine_x = {},
        lualine_z = {},
    },

    --tabline = {},
    --extensions = {},
}

local function in_left(component)
    table.insert(config.sections.lualine_c, component)
end

local function in_right(component)
    table.insert(config.sections.lualine_x, component)
end


in_left {
    function()
        return '▊'
    end,

    color = {fg = colors.magenta },

    padding = {left = 0, right = 1},
}

in_left {

    --mode component
    function()
        return 'ॐ '
    end,

    color = function()

        --auto change color according to neovims mode
        local mode_color = {
            n = colors.red,
            i = colors.green,
            v = colors.blue,
            ['^V'] = colors.blue,
            V = colors.blue,
            c = colors.magenta,
            no = colors.red,
            s = colors.orange,
            s = colors.orange,
            ['^S'] = colors.orange,
            ic = colors.yellow,
            R = colors.viole,
            cv = colors.red,
            ce = colors.red,
            r = colors.cyan,
            rm = colors.cyan,
            ['r?'] = colors.cyan,
            ['!'] = colors.red,
            t = colors.red,
        }
        return { fg = mode_color[vim.fn.mode()] }
    end,
    padding = { right = 1},
}

in_left {
    'filesize',
    cond = conditions.buffer_not_empty,
}

in_left {
    'filename',
    cond = conditions.buffer_not_empty,
    color = { fg = colors.yellow , gui = 'bold'},
}

in_left {'location'}

in_left { 'progress', color = {fg = colors.fg, gui = 'bold'}}

in_left {
    'diagnostics',
    sources = {'nvim_diagnostic'},
    symbols = { error = '🔴', warn = '⚠️', info = '☀'},
}
in_left {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = { error = '🔴', warn = '⚠️ ', info = '☀ ' },
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_warn = { fg = colors.yellow },
    color_info = { fg = colors.cyan },
  },
}


in_left {
    function()
        return '%='
    end
}

--[[in_left {
  -- Lsp server name .
  function()
    local msg = 'No Active Lsp'
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end,
  icon = ' LSP:',
  color = { fg = '#ffffff', gui = 'bold' },
}]]

-- Now lets add component to right section

in_right {
    'o:encoding',
    fmt = string.upper,
    cond = conditions.hide_in_width,
    color = { fg = colors.green, gui = 'bold'},
}

in_right {
    'fileformat',
    fmt = string.upper,
    icons_enabled = false,
    color = { fg = colors.green, gui = 'bold'},
}

in_right {
    'branch',
    icon = '',
    color = {gui = 'bold'}, 
}

in_right {
    'diff',
    symbols = { added = '+', modified= '🖊 ', removed = '❌ '},
    diff_color = {
        added = { fg = colors.green, gui = 'bold'},
        modified = { fg = colors.yellow, gui = 'bold'},
        removed = { fg = colors.red, gui = 'bold'},
    },
    cond = conditions. hide_in_width,
}

in_right {
    function()
        return '▊'
    end,
    color = { fg = colors.magenta},
    padding = {left = 1},
}


--load your config
lualine.setup(config)

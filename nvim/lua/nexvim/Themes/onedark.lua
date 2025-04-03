
-- One Dark theme 

local onedark = require('onedark')

-- Lua
onedark.setup  {
    -- Main options --
    style = 'deep', 
        -- Change code style ---
    -- Options are italic, bold, underline, none
    -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
    code_style = {
        comments = 'none',
        keywords = 'none',
        functions = 'bold',
        strings = 'none',
        variables = 'none'
    },
}

onedark.load()

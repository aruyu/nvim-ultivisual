--[[
-   NOTE      - configs.lua
-   Author    - Asta
-
-   Created   - 2023.02.27
-   Github    - https://github.com/astaos
-   Contact   - vine9151@gmail.com
]]



local M = {}

-- Default options.
local default_options = {
  --
  features = {
    indent = true,
    delimiter = true,
    paste = true,
  },

  --
  keymaps = {
    make_indent = {
      key = '<TAB>',
      modes = { 'v','n' }, -- 'v'; visual, 'n'; normal, 'i'; insert
    },

    delete_indent = {
      key = '<S-TAB>',
      modes = { 'v','n' }, -- 'v'; visual, 'n'; normal, 'i'; insert
    },

    delimiter = {
      { key = '(', shape = { '(',')' } },
      { key = '[', shape = { '[',']' } },
      { key = '{', shape = { '{','}' } },
    },

    paste = {
      key = '<C-V>',
      modes = { 'v','n','i' }, -- 'v'; visual, 'n'; normal, 'i'; insert
    },
  },
}


M.values = vim.deepcopy(default_options)

function M.setup_config(user_options)
  M.values = vim.tbl_extend('force', default_options, user_options or {})
end

-- This metatable allows for easier access to the config values. Instead of
-- writing `config.values.key` you can just write `config.key`.
return setmetatable(M, {
  __index = function(t, key)
    if key == "setup_config" then
      return t.setup_config
    else
      return t.values[key]
    end
  end,
})

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
  -- You can switch the ultimate visual features.
  features = {
    indent = true,
    bracket = true,
    paste = true,
  },

  -- The keymap settings for features here.
  -- key; mapped key
  -- modes; included mode (include Visual mode for ultimate features!)
  keymaps = {
    make_indent = {
      key = '<TAB>',
      modes = { 'v','n' }, -- 'v'; visual, 'n'; normal, 'i'; insert
    },

    delete_indent = {
      key = '<S-TAB>',
      modes = { 'v','n' }, -- 'v'; visual, 'n'; normal, 'i'; insert
    },

    bracket = {
      -- Only for 'v'; visual mode.
      -- You can config the bracket shapes whatever you want.
      { key = '(', shape = { '(',')' } },
      { key = '[', shape = { '[',']' } },
      { key = '{', shape = { '{','}' } },
    },

    paste = {
      key = '<C-V>',
      modes = { 'v','n','i' }, -- 'v'; visual, 'n'; normal, 'i'; insert
    },
  },

  -- The option settings for features here.
  options = {
    bracket = {
      -- Ignore the first line's indent when included while making bracket.
      ignore_indent = true,
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

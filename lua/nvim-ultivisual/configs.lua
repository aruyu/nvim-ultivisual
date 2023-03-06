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
    brackets = true,
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

    brackets = {
      -- Only for 'v'; visual mode.
      -- You can config the brackets' shape whatever you want.
      { key = '(', shapes = { '(',')' } },
      { key = '{', shapes = { '{','}' } },
    },

    paste = {
      key = '<C-V>',
      modes = { 'v','n','i' }, -- 'v'; visual, 'n'; normal, 'i'; insert
    },
  },

  -- The option settings for features here.
  options = {
    brackets = {
      -- Ignore the first line's indent when included while making brackets.
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

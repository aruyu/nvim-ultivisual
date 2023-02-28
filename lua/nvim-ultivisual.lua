--[[
-   NOTE      - nvim-ultivisual.lua
-   Author    - Asta
-
-   Created   - 2023.02.27
-   Github    - https://github.com/astaos
-   Contact   - vine9151@gmail.com
]]



local configs = require("nvim-ultivisual.configs")
local indent_utils = require("nvim-ultivisual.utils.indent")
local bracket_utils = require("nvim-ultivisual.utils.bracket")
local paste_utils = require("nvim-ultivisual.utils.paste")
local M = {}


function M.setup(opt)
  configs.setup_config(opt)

  if configs.features.indent == true then
    indent_utils.set_keymaps(configs.keymaps.make_indent, configs.keymaps.delete_indent)
  end
  if configs.features.bracket == true then
    bracket_utils.set_keymaps(configs.keymaps.bracket, configs.options.bracket)
  end
  if configs.features.paste == true then
    paste_utils.set_keymaps(configs.keymaps.paste)
  end
end

return M

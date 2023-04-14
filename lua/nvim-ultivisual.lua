--[[
-   NOTE      - nvim-ultivisual.lua
-   Author    - Aru
-
-   Created   - 2023.02.27
-   Github    - https://github.com/aruyu
-   Contact   - vine9151@gmail.com
]]



local configs = require("nvim-ultivisual.configs")
local indent_utils = require("nvim-ultivisual.utils.indent")
local brackets_utils = require("nvim-ultivisual.utils.brackets")
local paste_utils = require("nvim-ultivisual.utils.paste")
local M = {}


function M.setup(opt)
  configs.setup_config(opt)

  if configs.features.indent == true then
    indent_utils.set_keymaps(configs.keymaps.make_indent, configs.keymaps.delete_indent)
  end
  if configs.features.brackets == true then
    brackets_utils.set_keymaps(configs.keymaps.brackets, configs.options.brackets)
  end
  if configs.features.paste == true then
    paste_utils.set_keymaps(configs.keymaps.paste)
  end
end

return M

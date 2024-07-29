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
local copy_utils = require("nvim-ultivisual.utils.copy")
local delete_utils = require("nvim-ultivisual.utils.delete")
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
  if configs.features.copy == true then
    copy_utils.set_keymaps(configs.keymaps.copy, 'copy')
  end
  if configs.features.cut == true then
    copy_utils.set_keymaps(configs.keymaps.cut, 'cut')
  end
  if configs.features.delete == true then
    delete_utils.set_keymaps(configs.keymaps.delete)
  end
end

return M

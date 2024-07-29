--[[
-   NOTE      - copy.lua
-   Author    - Aru
-
-   Created   - 2024.07.29
-   Github    - https://github.com/aruyu
-   Contact   - vine9151@gmail.com
]]



require("nvim-ultivisual.string")

local M = {}
local keyset = vim.keymap.set
local noremap_opt = { noremap = true }
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end


function M.do_visual_copy_cut(feature)
  local present_column = vim.fn.col('.')
  local present_word = vim.fn.getline('.'):sub(present_column, present_column)
  local commands

  if feature == 'cut' then
    commands = 'd'
  elseif feature == 'copy' then
    commands = 'y'
  end

  if (present_word == '') and (present_column ~= 1) then
    vim.api.nvim_feedkeys(t('<Left>'), 'n', true)
    vim.api.nvim_feedkeys(t(commands .. '<ESC><ESC>'), 'n', true)
  else
    vim.api.nvim_feedkeys(t(commands .. '<ESC><ESC>'), 'n', true)
  end
end


function M.set_keymaps(keymaps, copy_cut)
  keyset('v', keymaps.key,
    '<CMD>lua require("nvim-ultivisual.utils.copy").do_visual_copy_cut("' .. copy_cut .. '")<CR>',
    noremap_opt
  )
end

return M

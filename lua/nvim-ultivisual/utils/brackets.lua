--[[
-   NOTE      - brackets.lua
-   Author    - Aru
-
-   Created   - 2023.02.27
-   Github    - https://github.com/aruyu
-   Contact   - vine9151@gmail.com
]]



require("nvim-ultivisual.string")

local M = {}
local keyset = vim.keymap.set
local noremap_opt = { noremap = true }


function M.make_group_brackets(front_character, back_character, options)
  options = options or false

  local line_start = vim.fn.line("'<")
  local line_end = vim.fn.line("'>")
  local col_start = vim.fn.col("'<")
  local col_end = vim.fn.col("'>")

  local front_line, selected_line, selected_start_line, back_line, added_char

  if col_start == 1 and options then
    local is_expandtab = vim.api.nvim_eval('&expandtab') == 1
    local column, indent_size, indent_style, indent_charactor

    if is_expandtab then
      indent_style = '%s+'
      indent_charactor = ' '
    else
      indent_style = '\t+'
      indent_charactor = '	'
    end

    column, indent_size = string.find(vim.fn.getline(line_start), indent_style)

    if indent_size == nil or column ~= 1 then
      front_line = vim.fn.getline(line_start):sub(1, col_start-1) .. front_character
      selected_line = vim.fn.getline(line_start):sub(col_start, col_end)
      selected_start_line = vim.fn.getline(line_start):sub(col_start)
    else
      front_line = indent_charactor:rep(indent_size) .. front_character
      selected_line = vim.fn.getline(line_start):sub(indent_size+1, col_end)
      selected_start_line = vim.fn.getline(line_start):sub(indent_size+1)
    end

  else
    front_line = vim.fn.getline(line_start):sub(1, col_start-1) .. front_character
    selected_line = vim.fn.getline(line_start):sub(col_start, col_end)
    selected_start_line = vim.fn.getline(line_start):sub(col_start)
  end

  back_line = back_character .. vim.fn.getline(line_end):sub(col_end+1)

  if line_start == line_end then
    front_line = front_line .. selected_line

    vim.fn.setline(line_end, front_line .. back_line)
    added_char = 2

  else
    front_line = front_line .. selected_start_line
    back_line = vim.fn.getline(line_end):sub(1, col_end) .. back_line

    vim.fn.setline(line_start, front_line)
    vim.fn.setline(line_end, back_line)
    added_char = 1
  end

  vim.api.nvim_call_function('cursor', { line_end,col_end+(added_char+1) })
end


function M.set_keymaps(keymaps, options)
  if options.ignore_indent == false then
    for _, keymap in ipairs(keymaps) do
      keyset('v', keymap.key,
        ':<ESC>:lua require("nvim-ultivisual.utils.brackets").make_group_brackets("' ..
        keymap.shapes[1] .. '","' .. keymap.shapes[2] .. '")<CR>',
        noremap_opt
      )
    end
  else
    for _, keymap in ipairs(keymaps) do
      keyset('v', keymap.key,
        ':<ESC>:lua require("nvim-ultivisual.utils.brackets").make_group_brackets("' ..
        keymap.shapes[1] .. '","' .. keymap.shapes[2] .. '",true)<CR>',
        noremap_opt
      )
    end
  end
end

return M

--[[
-   NOTE      - delimiter.lua
-   Author    - Asta
-
-   Created   - 2023.02.27
-   Github    - https://github.com/astaos
-   Contact   - vine9151@gmail.com
]]



local M = {}
local keyset = vim.keymap.set
local noremap_opt = { noremap = true }


function M.make_group_delimiter(front_character, back_character)
  local line_start = vim.fn.line("'<")
  local line_end = vim.fn.line("'>")
  local col_start = vim.fn.col("'<")
  local col_end = vim.fn.col("'>")

  local front_delimiter, back_delimiter

  if line_start == line_end then
    front_delimiter = vim.fn.getline(line_start):sub(1, col_start-1) .. front_character
    back_delimiter = vim.fn.getline(line_start):sub(col_start, col_end) .. back_character

    vim.fn.setline(line_start, front_delimiter .. back_delimiter .. vim.fn.getline(line_start):sub(col_end+1))

  else
    front_delimiter = vim.fn.getline(line_start):sub(1, col_start-1) .. front_character .. vim.fn.getline(line_start):sub(col_start)
    back_delimiter = vim.fn.getline(line_end):sub(1, col_end) .. back_character .. vim.fn.getline(line_end):sub(col_end+1)

    vim.fn.setline(line_start, front_delimiter)
    vim.fn.setline(line_end, back_delimiter)
  end
end


function M.set_keymaps(delimiter)
  for _, keymaps in ipairs(delimiter) do
    keyset('v', keymaps.key,
      ':<ESC>:lua require("nvim-ultivisual.utils.delimiter").make_group_delimiter("' .. keymaps.shape[1] .. '","' .. keymaps.shape[2] .. '")<CR>',
      noremap_opt
    )
  end
end

return M

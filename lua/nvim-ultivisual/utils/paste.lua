--[[
-   NOTE      - paste.lua
-   Author    - Asta
-
-   Created   - 2023.02.27
-   Github    - https://github.com/astaos
-   Contact   - vine9151@gmail.com
]]



require("nvim-ultivisual.string")

local M = {}
local keyset = vim.keymap.set
local noremap_opt = { noremap = true }


function M.do_group_paste()
  local line_start = vim.fn.line("'<")
  local line_end = vim.fn.line("'>")
  local col_start = vim.fn.col("'<")
  local col_end = vim.fn.col("'>")
  local yanked = vim.fn.getreg('"'):split('\n')

  local front_line, back_line
  local lines_table = {}
  local cursor_pos = { (line_start-1)+(#yanked) }

  front_line = vim.fn.getline(line_start):sub(1, col_start-1)
  back_line = vim.fn.getline(line_end):sub(col_end+1)

  if #yanked == 1 then
    front_line = front_line .. yanked[1]
    table.insert(cursor_pos, front_line:len())
    table.insert(lines_table, front_line .. back_line)

  else
    front_line = front_line .. yanked[1]
    back_line = yanked[#yanked] .. back_line
    table.insert(cursor_pos, yanked[#yanked]:len())

    lines_table = yanked
    table.remove(lines_table, 1)
    table.remove(lines_table, #yanked)
    table.insert(lines_table, 1, front_line)
    table.insert(lines_table, back_line)
  end

  vim.api.nvim_buf_set_lines(0, line_start-1, line_end, true, lines_table)
  vim.api.nvim_call_function('cursor', cursor_pos)
end


function M.set_keymaps(paste)
  keyset('v', paste.key,
    ':<ESC>:lua require("nvim-ultivisual.utils.paste").do_group_paste()<CR>',
    noremap_opt
  )
end

return M

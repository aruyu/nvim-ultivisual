--[[
-   NOTE      - paste.lua
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


function M.do_visual_paste()
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
    table.insert(cursor_pos, front_line:len()+1)
    table.insert(lines_table, front_line .. back_line)

  else
    front_line = front_line .. yanked[1]
    back_line = yanked[#yanked] .. back_line
    table.insert(cursor_pos, yanked[#yanked]:len()+1)

    lines_table = yanked
    table.remove(lines_table, 1)
    table.remove(lines_table, #yanked)
    table.insert(lines_table, 1, front_line)
    table.insert(lines_table, back_line)
  end

  vim.api.nvim_buf_set_lines(0, line_start-1, line_end, true, lines_table)
  vim.api.nvim_call_function('cursor', cursor_pos)
end

function M.do_normal_paste()
  local present_column = vim.fn.col('.')
  local present_line = vim.fn.line('.')
  local yanked = vim.fn.getreg('"'):split('\n')

  local front, back
  local lines_table = {}
  local cursor_pos = { (present_line-1)+(#yanked) }

  if present_column == 1 then
    front = vim.fn.getline(present_line):sub(1, present_column-1)
    back = vim.fn.getline(present_line):sub(present_column)
  else
    front = vim.fn.getline(present_line):sub(1, present_column)
    back = vim.fn.getline(present_line):sub(present_column+1)
  end

  if #yanked == 1 then
    front = front .. yanked[1]
    table.insert(cursor_pos, front:len())
    table.insert(lines_table, front .. back)

  else
    front = front .. yanked[1]
    back = yanked[#yanked] .. back
    table.insert(cursor_pos, yanked[#yanked]:len())

    lines_table = yanked
    table.remove(lines_table, 1)
    table.remove(lines_table, #yanked)
    table.insert(lines_table, 1, front)
    table.insert(lines_table, back)
  end

  vim.api.nvim_buf_set_lines(0, present_line-1, present_line, true, lines_table)
  vim.api.nvim_call_function('cursor', cursor_pos)
end

function M.do_insert_paste()
  local present_column = vim.fn.col('.')
  local present_line = vim.fn.line('.')
  local yanked = vim.fn.getreg('"'):split('\n')

  local front, back
  local lines_table = {}
  local cursor_pos = { (present_line-1)+(#yanked) }

  front = vim.fn.getline(present_line):sub(1, present_column-1)
  back = vim.fn.getline(present_line):sub(present_column)

  if #yanked == 1 then
    front = front .. yanked[1]
    table.insert(cursor_pos, front:len()+1)
    table.insert(lines_table, front .. back)

  else
    front = front .. yanked[1]
    back = yanked[#yanked] .. back
    table.insert(cursor_pos, yanked[#yanked]:len()+1)

    lines_table = yanked
    table.remove(lines_table, 1)
    table.remove(lines_table, #yanked)
    table.insert(lines_table, 1, front)
    table.insert(lines_table, back)
  end

  vim.api.nvim_buf_set_lines(0, present_line-1, present_line, true, lines_table)
  vim.api.nvim_call_function('cursor', cursor_pos)
end


function M.set_keymaps(keymaps)
  for _, mode in ipairs(keymaps.modes) do
    if mode == 'v' then
      keyset('v', keymaps.key,
        ':<ESC>:lua require("nvim-ultivisual.utils.paste").do_visual_paste()<CR>',
        noremap_opt
      )
    elseif mode == 'n' then
      keyset('n', keymaps.key,
        '<CMD>lua require("nvim-ultivisual.utils.paste").do_normal_paste()<CR>',
        noremap_opt
      )
    elseif mode == 'i' then
      keyset('i', keymaps.key,
        '<CMD>lua require("nvim-ultivisual.utils.paste").do_insert_paste()<CR>',
        noremap_opt
      )
    end
  end
end

return M

--[[
-   NOTE      - paste.lua
-   Author    - Asta
-
-   Created   - 2023.02.27
-   Github    - https://github.com/astaos
-   Contact   - vine9151@gmail.com
]]



local M = {}
local keyset = vim.keymap.set
local noremap_opt = { noremap = true }
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end


function M.do_group_paste()
  local line_start = vim.fn.line("'<")
  local line_end = vim.fn.line("'>")
  local col_start = vim.fn.col("'<")
  local col_end = vim.fn.col("'>")

  local combined_line

  combined_line = vim.fn.getline(line_start):sub(1, col_start-1) .. vim.fn.getline(line_end):sub(col_end+1)

  if line_start == line_end then
    vim.fn.setline(line_start, combined_line)

    vim.cmd('call cursor("' .. line_start .. '","' .. col_start-1 .. '")')
    vim.api.nvim_feedkeys(t('p<ESC>'), 'n', true)

  else
    vim.cmd('call nvim_buf_set_lines(0,' .. line_start-1 .. ',' .. line_end ..
      ',v:true,["' .. combined_line .. '"])'
    )

    vim.cmd('call cursor("' .. line_start .. '","' .. col_start-1 .. '")')
    vim.api.nvim_feedkeys(t('p<ESC>'), 'n', true)
  end
end


function M.set_keymaps(paste)
  keyset('v', paste.key,
    ':<ESC>:lua require("nvim-ultivisual.utils.paste").do_group_paste()<CR>',
    noremap_opt
  )
end

return M

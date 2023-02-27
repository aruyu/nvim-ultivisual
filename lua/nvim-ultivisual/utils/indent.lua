--[[
-   NOTE      - indent.lua
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
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end


function M.make_group_indent(novisual)
  novisual = novisual or false

  local is_expandtab = vim.api.nvim_eval('&expandtab') == 1
  local indent_size = vim.api.nvim_eval('&shiftwidth')
  local temp, indent_count, indent_diff

  local select_line_start = vim.fn.line("'<")
  local select_line_end = vim.fn.line("'>")
  local select_line_diff = select_line_end - select_line_start

  for line = select_line_start, select_line_end, 1 do
    temp, indent_count = string.find(vim.fn.getline(line), '%s+')

    if indent_count == nil or temp ~= 1 then
      indent_diff = 0
    else
      indent_diff = indent_size - (indent_count % indent_size)
    end

    if is_expandtab then
      if indent_diff == 0 then
        vim.fn.setline(line, string.rep(' ', indent_size) .. vim.fn.getline(line))
      else
        vim.fn.setline(line, string.rep(' ', indent_diff) .. vim.fn.getline(line))
      end
    else
      vim.fn.setline(line, '	' .. vim.fn.getline(line))
    end

    if vim.fn.getline(line) == string.rep(' ', indent_size) or vim.fn.getline(line) == '	' then
      vim.fn.setline(line, '')
    end
  end

  if novisual == false then
    if select_line_diff ~= 0 then
      vim.api.nvim_feedkeys(t('<S-V>'.. select_line_diff .. '-'), 'n', true)
    else
      vim.api.nvim_feedkeys(t('<S-A><ESC>'), 'n', true)
    end
  else
    vim.api.nvim_feedkeys(t('<S-A>'), 'n', true)
  end
end

function M.delete_group_indent(novisual)
  novisual = novisual or false

  local is_expandtab = vim.api.nvim_eval('&expandtab') == 1
  local indent_size = vim.api.nvim_eval('&shiftwidth')

  local select_line_start = vim.fn.line("'<")
  local select_line_end = vim.fn.line("'>")
  local select_line_diff = select_line_end - select_line_start

  for line = select_line_start, select_line_end, 1 do
    if is_expandtab then
      if vim.fn.getline(line):startswith(string.rep(' ', indent_size)) then
        vim.fn.setline(line, vim.fn.getline(line):replace_once(string.rep(' ', indent_size), ''))
      end

    else
      if vim.fn.getline(line):startswith('	') then
        vim.fn.setline(line, vim.fn.getline(line):replace_once('	', ''))
      end
    end
  end

  if novisual == false then
    if select_line_diff ~= 0 then
      vim.api.nvim_feedkeys(t('<S-V>'.. select_line_diff .. '-'), 'n', true)
    else
      vim.api.nvim_feedkeys(t('<S-A><ESC>'), 'n', true)
    end
  else
    vim.api.nvim_feedkeys(t('<S-A>'), 'n', true)
  end
end


function M.set_keymaps(make_indent, delete_indent)
  for _, mode in ipairs(make_indent.modes) do
    if mode == 'v' then
      keyset('v', make_indent.key,
        ':<ESC>:lua require("nvim-ultivisual.utils.indent").make_group_indent()<CR>',
        noremap_opt
      )
    elseif mode == 'n' then
      keyset('n', make_indent.key,
        'v:<ESC>:lua require("nvim-ultivisual.utils.indent").make_group_indent()<CR>',
        noremap_opt
      )
    elseif mode == 'i' then
      keyset('i', make_indent.key,
        '<ESC><ESC>v:<ESC>:lua require("nvim-ultivisual.utils.indent").make_group_indent(true)<CR>',
        noremap_opt
      )
    end
  end

  for _, mode in ipairs(delete_indent.modes) do
    if mode == 'v' then
      keyset('v', delete_indent.key,
        ':<ESC>:lua require("nvim-ultivisual.utils.indent").delete_group_indent()<CR>',
        noremap_opt
      )
    elseif mode == 'n' then
      keyset('n', delete_indent.key,
        'v:<ESC>:lua require("nvim-ultivisual.utils.indent").delete_group_indent()<CR>',
        noremap_opt
      )
    elseif mode == 'i' then
      keyset('i', delete_indent.key,
        '<ESC><ESC>v:<ESC>:lua require("nvim-ultivisual.utils.indent").delete_group_indent(true)<CR>',
        noremap_opt
      )
    end
  end
end

return M

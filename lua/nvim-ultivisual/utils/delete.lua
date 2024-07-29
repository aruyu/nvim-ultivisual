--[[
-   NOTE      - delete.lua
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


local function getword(index)
  return vim.fn.getline('.'):sub(vim.fn.col('.') - index, vim.fn.col('.') - index)
end

function M.do_delete()
  local present_column = vim.fn.col('.')

  if present_column ~= 1 then
    if getword(0) ~= '' then
      if getword(1) == ' ' and getword(2) == ' ' then
        vim.api.nvim_feedkeys(t('<ESC><ESC>v'), 'n', true)
        vim.api.nvim_feedkeys(t('<Left>'), 'n', true)
        vim.api.nvim_feedkeys(t('di'), 'n', true)

      elseif getword(1) == ' ' or getword(1) == '	' then
        vim.api.nvim_feedkeys(t('<ESC><ESC>vdi'), 'n', true)

      else
        vim.api.nvim_feedkeys(t('<ESC><ESC>vbdi'), 'n', true)
      end

    else
      if getword(1) == ' ' and getword(2) == ' ' then
        vim.api.nvim_feedkeys(t('<ESC><ESC>v'), 'n', true)
        vim.api.nvim_feedkeys(t('<Left>'), 'n', true)
        vim.api.nvim_feedkeys(t('da'), 'n', true)

      elseif getword(1) == ' ' or getword(1) == '	' then
        vim.api.nvim_feedkeys(t('<ESC><ESC>vda'), 'n', true)

      else
        vim.api.nvim_feedkeys(t('<ESC><ESC>vbda'), 'n', true)
      end
    end
  end
end


function M.set_keymaps(keymaps)
  for _, key in ipairs(keymaps.key) do
    keyset('i', key,
      '<CMD>lua require("nvim-ultivisual.utils.delete").do_delete()<CR>',
      noremap_opt
    )
  end
end

return M

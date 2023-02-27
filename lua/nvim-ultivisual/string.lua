--[[
-   NOTE      - string.lua
-   Author    - Asta
-
-   Created   - 2023.02.27
-   Github    - https://github.com/astaos
-   Contact   - vine9151@gmail.com
]]



function string:contains(sub)
  return self:find(sub, 1, true) ~= nil
end

function string:startswith(start)
  return self:sub(1, #start) == start
end

function string:endswith(ending)
  return ending == "" or self:sub(-#ending) == ending
end

function string:replace(old, new)
  local postfix, retval
  local search_start_idx = 1

  while true do
    local start_idx, end_idx = self:find(old, search_start_idx, true)
    if (not start_idx) then
      break
    end

    postfix = self:sub(end_idx + 1)
    retval = self:sub(1, (start_idx - 1)) .. new .. postfix

    search_start_idx = -1 * postfix:len()
  end

  return retval
end

function string:replace_once(old, new)
  local postfix, retval

  local start_idx, end_idx = self:find(old, 1, true)
  postfix = self:sub(end_idx + 1)
  retval = self:sub(1, (start_idx - 1)) .. new .. postfix

  return retval
end

function string:insert(pos, text)
  return self:sub(1, pos - 1) .. text .. self:sub(pos)
end

---@module File-type Lua code loaded after other plugins for CSV file-types.
---@author Roger Steve Ruiz
---@license MIT

local isCsvViewInstalled, csvview = pcall(require, "csvview")

if isCsvViewInstalled then
  -- Checking to see if the _CSV View_ mode is enabled in the current buffer
  -- (e.g. `0`).
  if not csvview.is_enabled(0) then
    csvview.enable()
  end
end

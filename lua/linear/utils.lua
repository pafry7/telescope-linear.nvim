local config = require('linear.init').config

local M = {}

M.OS = function()
  return package.config:sub(1, 1) == "\\" and "win" or "unix"
end

local get_current_path = function()
  local handle = io.popen("pwd")
  print(handle)
  if not handle then
    error("Cannot get api_key file")
  end
  local path = handle:read("*a")
  print(path)
  handle:close()
  return path
end

local file_exists = function(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

M.get_api_key = function()
  local path = get_current_path()
  print(path)
  -- local file = path .. '/' .. config.apiKeyFilename;
  -- print(file)
  -- if not file_exists(file) then return {} end
  -- local f = io.open(file)
  -- local api_key = f.read()
  -- f:close()
  -- print(api_key)
  -- return "test"
end

return M

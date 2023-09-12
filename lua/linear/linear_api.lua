local curl = require("plenary.curl")
local utils = require("linear.utils")

local base_url = "https://api.linear.app/graphql"
local api_key = ""

local M = {}

M.getIssues = function()
  local test = utils.get_api_key()
  local response = vim.fn.json_decode(curl.post(
    base_url, {
    body = vim.fn.json_encode({ query = "query Query {  issues {    nodes {      branchName    }  }}" }),
    headers = { Authorization = api_key, content_type = "application/json" }
  }).body)
  if not response then return {} end
  return response.data.issues.nodes;
end

return M

local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

local linear_api = require('linear.linear_api')

local debug_print = function(object)
  print(vim.inspect(object))
end


local M = {}

M.config = {
  apiKeyFilename = ".linear_apikey"
}


M.setup = function(config)
  M.config = vim.tbl_extend("force", M.config, config or {})
end

local select_default = function(prompt_bufnr)
  actions.close(prompt_bufnr)
  local selection = action_state.get_selected_entry()
  os.execute("echo " .. selection.value .. " | pbcopy")
end

M.run = function(opts)
  opts = opts or {}

  local issues = linear_api.getIssues()

  pickers.new(opts, {
    prompt_title = 'Search Tasks',
    finder = finders.new_table {
      results = issues,
      entry_maker = function(entry)
        return {
          value = entry.branchName,
          display = entry.branchName,
          ordinal = entry.branchName
        }
      end
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        select_default(prompt_bufnr)
      end)
      return true
    end,
  }):find()
end

return M

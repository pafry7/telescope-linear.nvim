local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

local linear_api = require('linear.linear_api')


local M = {}

-- maybe user credentials should be there
-- user credentials passed with plugin config

-- M.setup = function(config)
--   M.config = vim.tbl_extend("force", M.config, config or {})
--   -- print(vim.inspect(M.config))
-- end

local select_default = function(prompt_bufnr)
  actions.close(prompt_bufnr)
  local selection = action_state.get_selected_entry()

  -- selected task, get branch name and copy to clipboard
end

M.run = function(opts)
  opts = opts or {}
  local projects = {}

  -- connect with linear API and get all projects and tasks

  -- entry_maker
  local entry_maker = function(entry)
    local display = entry.name .. " (" .. entry.osVersion .. ")"
    if entry.state then
      display = display .. " (" .. entry.state .. ")"
    end
    return {
      value = entry,
      display = display,
      ordinal = display,
    }
  end

  pickers.new(opts, {
    prompt_title = 'Search Tasks',
    finder = finders.new_table {
      results = {}, -- tasks here
      entry_maker = entry_maker,
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
-- M.run()
return M

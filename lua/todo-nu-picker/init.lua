local nu_config = "C:\\Users\\patrick.joerg\\Appdata\\Roaming\\nushell\\config.nu"
local wiki_path = "C:\\Users\\patrick.joerg\\vimwiki\\"

local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local previewers = require "telescope.previewers"
local action_state = require "telescope.actions.state"
local utils = require "telescope.utils"

opts = opts or {}

local function get_todos(opts)
  local cmd = "--config " .. nu_config .. " -c 'td | to json'"
  opts.cmd = {"nu", cmd}
  response =  utils.get_os_command_output(opts.cmd)
  local res = ""
  for i,v in ipairs(response) do 
    res = res .. v
  end
  return vim.json.decode(res)
end

-- our picker function:
local todo_nu = function(opts)
  opts = opts or {}

  pickers.new(opts, {
    prompt_title = "todo-nu",
    results_title = "todo-nu",
    finder = finders.new_table {
      results = get_todos(opts),
      entry_maker = function(entry) -- gets called for every entry
        return {
          value = entry,
          display = entry["todo"] .. " " .. entry["item"], -- Text as well as the icon get displayed
          ordinal = entry["item"], -- the values for which they get sorted
          filename = wiki_path .. entry["file"] .. '.md', -- The file to open
          lnum = tonumber(entry["line"]), -- at this line number
        }
      end,
    },
    -- previewer = previewers.get_previewer(opts),
    sorter = conf.generic_sorter(opts),
    -- attach_mappings = function(prompt_bufnr, map)
    --   actions.select_default:replace(function()
    --     actions.close(prompt_bufnr)
    --     local selection = action_state.get_selected_entry()
    --     vim.api.nvim_put({ selection[1] }, "", false, true)
    --   end)
    --   return true
    -- end,
  }):find()
end

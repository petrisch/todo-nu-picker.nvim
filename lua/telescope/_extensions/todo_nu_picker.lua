local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local utils = require("telescope.utils")

local M = {}

M.setup = function(ext_config)
	local config = ext_config
	Nu_config = config.ext_config.nu_config or "~/.config/nushell/config.nu"
	Wiki_path = config.ext_config.wiki_path or "~/wiki"
end

local function get_todos(opts)
	local cmd = "--config " .. Nu_config .. " -c 'td | to json'"
	opts.cmd = { "nu", cmd }
	local response = utils.get_os_command_output(opts.cmd)
	local res = ""
	for _, v in ipairs(response) do
		res = res .. v
	end
	return vim.json.decode(res)
end

-- our picker function:
M.todo_nu_picker = function(opts)
	opts = opts or {}

	pickers
		.new(opts, {
			prompt_title = "todo-nu",
			results_title = "todo-nu",
			finder = finders.new_table({
				results = get_todos(opts),
				entry_maker = function(entry) -- gets called for every entry
					return {
						value = entry,
						display = entry["todo"] .. " " .. entry["file"] .. " | " .. entry["item"], -- Text as well as the icon get displayed
						ordinal = entry["file"] .. entry["item"], -- the values for which they get sorted
						filename = Wiki_path .. entry["file"] .. ".md", -- The file to open
						lnum = tonumber(entry["line"]), -- at this line number
					}
				end,
			}),
			-- For now the generic_sorter is enough.
			-- Maybe this could be used if a priority or sprint colunm is added to todo-nu
			sorter = conf.generic_sorter(opts),
			-- attach_mappings = function(prompt_bufnr, map)
			--   actions.select_default:replace(function()
			--     actions.close(prompt_bufnr)
			--     local selection = action_state.get_selected_entry()
			--     vim.api.nvim_put({ selection[1] }, "", false, true)
			--   end)
			--   return true
			-- end,
		})
		:find()
end

return require("telescope").register_extension({
	setup = M.setup,
	-- vim.print(M.opts),

	exports = {
		todo_nu_picker = M.todo_nu_picker,
	},
})

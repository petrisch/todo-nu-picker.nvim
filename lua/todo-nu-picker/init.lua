local M = {}

M.setup = function(opts)
	Nu_config = opts.nu_config
	Wiki_path = opts.wiki_path
	if opts.picker == "telescope" then
		require("telescope").setup({
			extensions = {
				todo_nu_picker = {}, -- Gets config from this module directly
			},
		})
	elseif opts.picker == "snacks" then
		require("snacks_picker.snacks_picker").setup(opts)
		-- Snacks.notifier.notify(opts.picker, "warn")
	end
end

return M

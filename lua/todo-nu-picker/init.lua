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
	elseif opts.picker == "fzf-lua" then
		require("fzf-lua.fzf-lua-picker").setup(opts)
	end
end

return M

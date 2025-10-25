local utils = require("telescope.utils")

local M = {}

M.setup = function(todo_opts)
	Nu_config = todo_opts.nu_config or "~/.config/nushell/config.nu"
	Wiki_path = todo_opts.wiki_path or "~/wiki"
	-- Snacks.notifier.notify("setup fzf: " .. Nu_config, "warn")

	function Pick()
		M.fzf_pick_todo(todo_opts)
	end

	vim.keymap.set("n", "<leader>fd", Pick, { silent = true, desc = "Get todos" })
end

M.fzf_pick_todo = function(opts)
	opts = opts or {}
	local fzf_lua = require("fzf-lua")
	opts.prompt = "todos> "
	opts.fn_transform = function(x)
		local res = string.gsub(x, "\t", " | ")
		return res
	end
	opts.actions = {
		["default"] = function(selected)
			local i = 0
			local file = ""
			local lnum = ""
			for entry in string.gmatch(selected[1], "[^|]+") do
				i = i + 1
				if i == 3 then
					file = vim.fs.normalize(opts.wiki_path .. string.gsub(entry, "%s+", "") .. ".md")
				end
				if i == 4 then
					lnum = entry
				end
			end
			vim.cmd("e" .. file .. " | " .. lnum)
		end,
	}
	local cmd = "nu " .. "--config " .. opts.nu_config .. " -c 'td | to tsv | lines | skip 1 | to text'"
	fzf_lua.fzf_exec(cmd, opts)
end

return M

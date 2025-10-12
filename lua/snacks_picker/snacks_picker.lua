local M = {}

M.setup = function(todo_opts)
	-- Nu_config = config.Nu_config or "~/.config/nushell/config.nu"
	-- Wiki_path = config.Wiki_path or "~/wiki"

	Snacks.notifier.notify("asdf blbl", "warn")
	Snacks.picker.pick({
		finder = function(picker, opts)
			return function(ctx)
				Snacks.picker.util.cmd(
					{ "nu", "--config" .. todo_opts.nu_config .. " -c", "td | to json" },
					function(lines)
						local items = {}
						local res = ""
						for _, line in ipairs(lines) do
							res = res .. line
						end
						items = vim.json.decode(res)
						ctx.emit(items)
						ctx.done()
					end
				) -- , { cwd = opts.cwd })
			end
		end,
		format = "file",
		preview = "file",
		confirm = "jump",
		-- filename = todo_opts.wiki_path .. entry["file"] .. ".md", -- The file to open
		-- lnum = tonumber(entry["line"]), -- at this line number
	})
end

return M

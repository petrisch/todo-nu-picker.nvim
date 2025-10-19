-- Snacks_config = require("Snacks.picker").Config

local M = {}

M.setup = function(todo_opts)
	Nu_config = todo_opts.Nu_config or "~/.config/nushell/config.nu"
	Wiki_path = todo_opts.Wiki_path or "~/wiki"
	Snacks.notifier.notify("setup calling", "warn")

	function Pick()
		return M.picker(todo_opts)
	end

	vim.keymap.set("n", "<leader>fD", Pick, { silent = true, desc = "Show Dashboard" })
end

M.finder = function(opts)
	Snacks.notifier.notify("registering picker", "warn")
	return function(ctx)
		local cmd = "nu " .. "--config " .. opts.nu_config .. " -c 'td | to json'"
		-- local cmd = "git log"
		Snacks.notifier.notify("command is: " .. cmd, "warn")

		Snacks.picker.util.cmd(cmd, function(lines)
			-- Snacks.notifier.notify("lines from nu: " .. lines, "warn")
			local res = ""
			-- local res = "{'items:'"
			for _, line in ipairs(lines) do
				res = res .. line
			end
			-- res = res .. "}"
			Snacks.notifier.notify("Res: " .. res, "warn")
			local items = vim.json.decode(res)
			Snacks.notifier.notify("Items: " .. vim.inspect(items), "warn")
			Snacks.notifier.notify("Items: " .. vim.inspect(items.file), "warn")
			-- So far this items is a table wit hte right thing in it, but what form do we actually need?
			ctx.emit(items)
			ctx.done()
		end, { cwd = opts.wiki_path })
	end
end

M.picker = function(opts)
	Snacks.picker.pick({
		finder = M.finder(opts),
		format = "file",
		preview = "file",
		confirm = "jump",
		-- filename = todo_opts.wiki_path .. entry["file"] .. ".md", -- The file to open
		-- lnum = tonumber(entry["line"]), -- at this line number
	})
end

return M

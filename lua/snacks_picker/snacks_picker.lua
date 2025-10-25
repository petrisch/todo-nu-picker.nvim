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

-- M.finder = function(opts)
-- 	-- Snacks.notifier.notify("registering picker", "warn")
-- 	return function(ctx)
-- 		local items = {}
-- 		local cmd = "nu " .. "--config " .. opts.nu_config .. " -c 'td | to json'"
-- 		-- local cmd = "git log"
-- 		Snacks.notifier.notify("command is: " .. cmd, "warn")
--
-- 		Snacks.picker.util.cmd(cmd, function(lines)
-- 			-- Snacks.notifier.notify("lines from nu: " .. lines, "warn")
-- 			local response = ""
-- 			-- local res = "{'items:'"
-- 			for _, line in ipairs(lines) do
-- 				response = response .. line
-- 			end
-- 			-- res = res .. "}"
-- 			Snacks.notifier.notify("Res: " .. response, "warn")
-- 			local result = vim.json.decode(response)
-- 			Snacks.notifier.notify("Items: " .. vim.inspect(result), "warn")
-- 			-- local items = {}
-- 			for k, v in pairs(result) do
-- 				-- Snacks.notifier.notify("Item: " .. vim.inspect(v["file"]), "warn")
-- 				local t = {}
-- 				t["text"] = v["todo"]
-- 				t["file"] = v["file"] .. ".md"
-- 				table.insert(items, t)
-- 			end
-- 			Snacks.notifier.notify("snacksitems: " .. vim.inspect(items), "warn")
-- 			ctx.emit(items)
-- 			ctx.done()
-- 		end, { cwd = opts.cwd })
-- 		-- return items
-- 	end
-- end

M.picker = function(todo_opts)
	Snacks.picker.pick({
		-- finder = M.finder(opts),
		finder = function(opts)
			-- Snacks.notifier.notify("registering picker", "warn")
			return function(ctx)
				local items = {}
				local cmd = "nu " .. "--config " .. todo_opts.nu_config .. " -c 'td | to json'"
				-- local cmd = "git log"
				Snacks.notifier.notify("command is: " .. cmd, "warn")

				Snacks.picker.util.cmd(cmd, function(lines)
					-- Snacks.notifier.notify("lines from nu: " .. lines, "warn")
					local response = ""
					-- local res = "{'items:'"
					for _, line in ipairs(lines) do
						response = response .. line
					end
					-- res = res .. "}"
					Snacks.notifier.notify("Res: " .. response, "warn")
					local result = vim.json.decode(response)
					Snacks.notifier.notify("Items: " .. vim.inspect(result), "warn")
					-- local items = {}
					for k, v in pairs(result) do
						-- Snacks.notifier.notify("Item: " .. vim.inspect(v["file"]), "warn")
						local t = {}
						t["text"] = v["todo"]
						t["file"] = v["file"] .. ".md"
						table.insert(items, t)
					end
					Snacks.notifier.notify("snacksitems: " .. vim.inspect(items), "warn")
					ctx.emit(items)
					ctx.done()
				end, { cwd = opts.cwd })
				-- return items
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

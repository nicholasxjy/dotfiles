local oil = require("oil")
oil.setup({
	default_file_explorer = true,
	watch_for_changes = false,
	skip_confirm_for_simple_edits = true,
	view_options = {
		show_hidden = true,
	},
	confirmation = {
		border = "solid",
	},
	preview_win = {
		update_on_cursor_moved = true,
	},
	keymaps = {
		["q"] = "actions.close",
		["<Esc>"] = "actions.parent",
	},
})

vim.api.nvim_create_autocmd("User", {
	pattern = "OilEnter",
	callback = function()
		oil.open_preview({ vertical = true, split = "belowright" })
	end,
})

vim.keymap.set("n", "<leader>o", function()
	oil.open()
end, { desc = "Oil", silent = true })

vim.api.nvim_create_autocmd("User", {
	pattern = "OilActionsPost",
	callback = function(event)
		local action = event.data.actions[1]
		if action and action.type == "move" then
			Snacks.rename.on_rename_file(action.src_url, action.dest_url)
		end
	end,
})

return {
	"nvim-telescope/telescope.nvim",
	main = "telescope",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		defaults = {
			prompt_prefix = " 󰭎  ",
			selection_caret = " ",
			path_display = { "absolute" },
			sorting_strategy = "ascending",
			layout_config = {
				height = 0.8,
				width = 0.7,
				prompt_position = "top",
			},
			mappings = {
				n = {
					["<C-t>"] = "nop",
				},
				i = {
					["<C-t>"] = "nop",
				},
			},
		},
		pickers = {
			find_files = {
				hidden = true,
			},
			git_files = {
				hidden = true,
			},
			live_grep = {
				hidden = true,
			},
		},
	},
	keys = function()
		local builtin = require("telescope.builtin")

		return {
			{ "<C-p>", builtin.find_files, silent = true, noremap = true },
			{ "<leader>pg", builtin.git_files, silent = true, noremap = true },
			{ "<leader>ps", builtin.live_grep, silent = true, noremap = true },
			{ "<leader>vh", builtin.help_tags, silent = true, noremap = true },
			{
				"<leader>pws",
				function()
					local word = vim.fn.expand("<cword>")
					builtin.grep_string({ search = word })
				end,
				silent = true,
				noremap = true,
			},
			{
				"<leader>pWs",
				function()
					local word = vim.fn.expand("<cWORD>")
					builtin.grep_string({ search = word })
				end,
			},
		}
	end,
}

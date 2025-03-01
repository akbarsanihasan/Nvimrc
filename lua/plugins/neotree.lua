return {
	"nvim-neo-tree/neo-tree.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	event = { "BufEnter" },
	keys = {
		{ "<leader>pv", ":Neotree toggle<CR>", silent = true, noremap = true },
	},
	init = function()
		vim.g.netrw_browse_split = 0
		vim.g.netrw_banner = 0
		vim.g.netrw_winsize = 25
		vim.g.loaded_netrwPlugin = 1
		vim.g.loaded_netrw = 1
	end,
	opts = {
		sort_function = function(a, b)
			if a.type == b.type then
				if a.ext == nil and b.ext == nil then
					return a.path < b.path
				end

				if a.ext == nil then
					return false
				end

				if b.ext == nil then
					return true
				end

				if a.ext == b.ext then
					return a.path < b.path
				end

				return a.ext < b.ext
			end

			return a.type < b.type
		end,
		default_component_configs = {
			indent = {
				with_expanders = true,
				expander_collapsed = "",
				expander_expanded = "",
			},
			icon = {
				folder_closed = "󰉋",
				folder_open = "󰝰",
				folder_empty = "󰉖",
				default = "",
			},
			git_status = {
				symbols = {
					added = "a",
					modified = "m",
					deleted = "d",
					renamed = "r",
					-- Status type
					untracked = "u",
					ignored = "i",
					unstaged = "U",
					staged = "s",
					conflict = "c",
				},
			},
		},
		window = {
			position = "current",
			mappings = {
				["t"] = {
					"toggle_node",
					nowait = false,
				},
				["<tab>"] = "open",
			},
		},
		filesystem = {
			hijack_netrw_behavior = "open_current",
			group_empty_dirs = true,
			use_libuv_file_watcher = false,
			follow_current_file = {
				enabled = true,
				leave_dirs_open = false,
			},
			commands = {
				delete = function(state)
					local inputs = require("neo-tree.ui.inputs")
					local path = state.tree:get_node().path
					local msg = "Are you sure you want to trash " .. path

					inputs.confirm(msg, function(confirmed)
						if not confirmed then
							return
						end

						vim.fn.system({ "trash", vim.fn.fnameescape(path) })
						require("neo-tree.sources.manager").refresh(state.name)
					end)
				end,
				delete_visual = function(state, selected_nodes)
					local inputs = require("neo-tree.ui.inputs")
					local msg = "Are you sure you want to trash " .. #selected_nodes .. " files ?"

					inputs.confirm(msg, function(confirmed)
						if not confirmed then
							return
						end

						for _, node in ipairs(selected_nodes) do
							vim.fn.system({ "trash", vim.fn.fnameescape(node.path) })
						end
						require("neo-tree.sources.manager").refresh(state.name)
					end)
				end,
			},
		},
	},
}

return {
	"willothy/nvim-cokeline",
	-- event = fileopened,
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim", -- Required for v0.4.0+
		-- "nvim-tree/nvim-web-devicons", -- If you want devicons
		"stevearc/resession.nvim", -- Optional, for persistent history
	},
	config = function()
		-- Mode color switch
		vim.api.nvim_create_autocmd({ "ModeChanged" }, {
			pattern = { "*" },
			command = "redrawtabline",
		})

		vim.keymap.set("n", "<S-Tab>", "<Plug>(cokeline-focus-prev)", { silent = true })
		vim.keymap.set("n", "<Tab>", "<Plug>(cokeline-focus-next)", { silent = true })
		vim.keymap.set("n", "<Leader>N", "<Plug>(cokeline-switch-prev)", { silent = true })
		vim.keymap.set("n", "<Leader>I", "<Plug>(cokeline-switch-next)", { silent = true })
		for i = 1, 9 do
			vim.keymap.set("n", ("<leader>%s"):format(i), ("<Plug>(cokeline-focus-%s)"):format(i), { silent = true })
			vim.keymap.set("n", ("<leader>d%s"):format(i), ("<Plug>(cokeline-switch-%s)"):format(i), { silent = true })
		end
		local is_picking_focus = require("cokeline/mappings").is_picking_focus
		local is_picking_close = require("cokeline/mappings").is_picking_close

		local green_bg = "#79740e"
		local aqua_bg = "#1f5333"
		local blue_bg = "#315653"
		local red_bg = "#9d0006"
		local yellow_bg = "#7a500c"
		local green_fg = "#b8bb26"
		local aqua_fg = "#8ec07c"
		local blue_fg = "#83a598"
		local red_fg = "#fb4934"
		local yellow_fg = "#fabd2f"

		local text_normal = "#a89984"
		local text_insert = "#83a598"
		local text_visual = "#fe8019"
		local text_command = "#b8bb26"
		local text_replace = "#fb4934"

		local text2_normal = "#7c6f64"
		local text2_insert = "#458588"
		local text2_visual = "#d65d0e"
		local text2_command = "#98971a"
		local text2_replace = "#cc241d"
		local dark = "#3c3836"
		local dark2_normal = "#504945"
		local dark3_normal = "#665c54"
		local default_text = function()
			if vim.api.nvim_get_mode().mode == "n" then
				return text_normal
			end
			if vim.api.nvim_get_mode().mode == "i" then
				return text_insert
			end
			if vim.api.nvim_get_mode().mode == "v" or vim.api.nvim_get_mode().mode == "V" then
				return text_visual
			end
			if vim.api.nvim_get_mode().mode == "c" then
				return text_command
			end
			if vim.api.nvim_get_mode().mode == "R" then
				return text_replace
			end
			return text_normal
		end
		local default_text2 = function()
			if vim.api.nvim_get_mode().mode == "n" then
				return text2_normal
			end
			if vim.api.nvim_get_mode().mode == "i" then
				return text2_insert
			end
			if vim.api.nvim_get_mode().mode == "v" or vim.api.nvim_get_mode().mode == "V" then
				return text2_visual
			end
			if vim.api.nvim_get_mode().mode == "c" then
				return text2_command
			end
			if vim.api.nvim_get_mode().mode == "R" then
				return text2_replace
			end
			return text2_normal
		end
		local dia_fg = function(buffer)
			if buffer.is_focused then
				return (buffer.diagnostics.errors ~= 0 and red_bg)
					or (buffer.diagnostics.warnings ~= 0 and yellow_bg)
					or (buffer.diagnostics.hints ~= 0 and aqua_bg)
					or (buffer.diagnostics.infos ~= 0 and blue_bg)
					or dark
			else
				return (buffer.diagnostics.errors ~= 0 and red_fg)
					or (buffer.diagnostics.warnings ~= 0 and yellow_fg)
					or (buffer.diagnostics.hints ~= 0 and aqua_fg)
					or (buffer.diagnostics.infos ~= 0 and blue_fg)
					or text_normal
			end
		end
		local function get_path_parts(path)
			local dirs = {}
			for dir in string.gmatch(path, "([^/]+)") do
				table.insert(dirs, dir)
			end

			local filename = dirs[#dirs]
			if filename ~= nil and string.sub(filename, 1, 1) == "+" then
				local ext = filename:match("^.+(%..+)$")
				local last_dir = dirs[#dirs - 1]
				if last_dir == "[id]" and path:match("api") and filename == "+server.ts" then
					local id_index = 0
					for i, dir in ipairs(dirs) do
						if dir == "[id]" then
							id_index = i
						end
					end
					local new_dir = dirs[id_index - 1]
					return new_dir .. "/[id]/" .. filename
				elseif last_dir == "[id]" then
					local id_index = 0
					for i, dir in ipairs(dirs) do
						if dir == "[id]" then
							id_index = i
						end
					end
					local new_dir = dirs[id_index - 1]
					return new_dir .. "/[id]/" .. filename
				elseif path:match("api") then
					local api_index = 0
					for i, dir in ipairs(dirs) do
						if dir == "api" then
							api_index = i
						end
					end
					local api_next_dir = dirs[api_index + 1]
					return "api/" .. api_next_dir .. "/" .. filename
				elseif ext == nil then
					local dir = dirs[#dirs - 1]
					return dir .. "/" .. filename
				else
					local dir = dirs[#dirs - 1]
					return dir .. "/" .. filename
				end
			end
		end

		local sidebar_bg_1 = function ()
      if vim.o.filetype == 'neo-tree' or vim.o.filetype == 'Trouble' or vim.o.filetype == 'Outline' then
        return default_text()
      end
      return dark2_normal
    end

    local sidebar_bg_2 = function ()
      if vim.o.filetype == 'neo-tree' or vim.o.filetype == 'Trouble' or vim.o.filetype == 'Outline' then
        return default_text2()
      end
      return dark2_normal
    end

    local sidebar_fg = function ()
      if vim.o.filetype == 'neo-tree' or vim.o.filetype == 'Trouble' or vim.o.filetype == 'Outline' then
        return dark
      end
      return text_normal
    end

		require("cokeline").setup({
			sidebar = {
				filetype = { "neo-tree", "Trouble", "Outline" },
				components = {
					{
            -- text = function()
            -- 	if vim.o.filetype == "neo-tree" then
            -- 		return " "
            -- 	end
            -- 	return ""
            -- end,
						text = " ",
						fg = function ()
              return sidebar_fg()
						end,
						bg = function()
              return sidebar_bg_2()
						end,
						on_click = function()
							vim.cmd("Neotree toggle")
						end,
					},
					{
						text = " 󰈔",
						fg = function ()
              return sidebar_fg()
						end,
						bg = function()
              return sidebar_bg_2()
						end,
						on_click = function()
							require("neo-tree.command").execute({ source = "buffers", toggle = true })
						end,
					},
					{
						text = " ",
						fg = function ()
              return sidebar_fg()
						end,
						bg = function()
              return sidebar_bg_2()
						end,
						on_click = function()
							require("neo-tree.command").execute({ source = "git_status", toggle = true })
						end,
					},
					{
						text = " ",
						fg = function ()
              return sidebar_fg()
						end,
						bg = function()
              return sidebar_bg_2()
						end,
						on_click = function()
							vim.cmd("TroubleToggle")
						end,
					},
					{
						text = " 󰅌 ",
						fg = function ()
              return sidebar_fg()
						end,
						bg = function()
              return sidebar_bg_2()
						end,
						on_click = function()
							vim.cmd("Outline")
						end,
					},
					{
						text = " Sidebar",
						fg = function ()
              return sidebar_fg()
						end,
						bold = function ()
              if vim.o.filetype == 'neo-tree' or vim.o.filetype == 'Trouble' or vim.o.filetype == 'Outline' then
                return true
              end
              return false
						end,
						bg = function()
              return sidebar_bg_1()
						end,
					},
				},
			},
			rhs = {
				{
					text = function()
					  if vim.fn.expand('%') == '' or vim.fn.expand('%') == nil then
					    return ' ' .. vim.o.filetype .. ' '
            else
              if os.getenv('HOME') == string.sub(vim.fn.expand('%'), 1, string.len(os.getenv('HOME'))) then
                return '~' .. string.sub(vim.fn.expand('%'), (string.len(vim.fn.expand('%')) - string.len(os.getenv('HOME'))) * -1 ) .. ' '
              end
              return " " .. vim.fn.expand("%") .. " "
            end
						-- return " " .. vim.fn.expand("%") .. " "
					end,
					fg = text_normal,
					bg = dark,
					on_click = function()
						vim.cmd("Neotree dir=%:p:h toggle")
					end,
				},
				{
					text = "󰀫 ",
					fg = text_normal,
					bg = dark,
					on_click = function()
						vim.cmd([[Alpha]])
					end,
				},
				{
					text = " ",
					fg = text_normal,
					bg = dark,
					on_click = function()
						vim.cmd([[Neotree toggle]])
					end,
				},
				{
					text = "  ",
					fg = green_fg,
					bg = dark2_normal,
					on_click = function()
						vim.cmd([[RunCode]])
					end,
				},
				{
					text = " ",
					fg = green_fg,
					bg = dark2_normal,
					on_click = function()
						require("dap").continue()
					end,
				},
				{
					-- text = "  ",
					text = '  ',
					fg = dark,
					bg = function()
					  if vim.o.filetype ~= 'neo-tree' and vim.o.filetype ~= 'Trouble' and vim.o.filetype ~= 'Outline' then
              return default_text()
            end
            return default_text2()
					end,
					on_click = function()
						vim.cmd([[help]])
					end,
				},
			},
			default_hl = {
				fg = function(buffer)
					if buffer.is_focused then
						return dark
					end
					return default_text()
				end,
				bg = function(buffer)
					if buffer.is_focused then
						return default_text()
					end
					return dark2_normal
				end,
				bold = function(buffer)
					if buffer.is_focused then
						return true
					end
				end,
			},
			components = {
				{
					text = function(buffer)
						return " " .. buffer.index .. " "
					end,
					fg = function(buffer)
						if buffer.is_focused then
							return dark
						else
							return text_normal
						end
					end,
					bg = function(buffer)
						if buffer.is_focused then
							return default_text2()
						end
						return dark3_normal
					end,
				},
				{
					text = function(buffer)
						if is_picking_focus() or is_picking_close() then
							return buffer.pick_letter .. " "
						end

						return " " .. buffer.devicon.icon
					end,
					fg = function(buffer)
						return dia_fg(buffer)
					end,
					style = function(_)
						return (is_picking_focus() or is_picking_close()) and "italic,bold" or nil
					end,
				},
				{
					text = function(buffer)
						if get_path_parts(buffer.path) ~= nil then
							return get_path_parts(buffer.path) .. " "
						else
							return buffer.unique_prefix .. buffer.filename .. " "
						end
					end,
					fg = function(buffer)
						return dia_fg(buffer)
					end,
				},
				{
					text = function(buffer)
						return (buffer.diagnostics.errors ~= 0 and "Er " .. buffer.diagnostics.errors .. " ")
							or (buffer.diagnostics.warnings ~= 0 and "Wn " .. buffer.diagnostics.warnings .. " ")
							or (buffer.diagnostics.hints ~= 0 and "Ht " .. buffer.diagnostics.hints .. " ")
							or (buffer.diagnostics.infos ~= 0 and "Io " .. buffer.diagnostics.infos .. " ")
							or ""
					end,
					fg = function(buffer)
						return dia_fg(buffer)
					end,
				},
				{
					text = function(buffer)
						return buffer.is_modified and "● " or "x "
					end,
					fg = function(buffer)
						return dia_fg(buffer)
					end,
					on_click = function(_, _, _, _, buffer)
						buffer:delete()
					end,
				},
			},
		})
	end,
}

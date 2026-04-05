return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#131313',
				base01 = '#131313',
				base02 = '#a59e94',
				base03 = '#a59e94',
				base04 = '#fff6e9',
				base05 = '#fffbf6',
				base06 = '#fffbf6',
				base07 = '#fffbf6',
				base08 = '#ff8379',
				base09 = '#ff8379',
				base0A = '#ffc367',
				base0B = '#96ff82',
				base0C = '#ffdfae',
				base0D = '#ffc367',
				base0E = '#ffce82',
				base0F = '#ffce82',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#a59e94',
				fg = '#fffbf6',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#ffc367',
				fg = '#131313',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#a59e94' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#ffdfae', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#ffce82',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#ffc367',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#ffc367',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#ffdfae',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#96ff82',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#fff6e9' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#fff6e9' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#a59e94',
				italic = true
			})

			local current_file_path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"
			if not _G._matugen_theme_watcher then
				local uv = vim.uv or vim.loop
				_G._matugen_theme_watcher = uv.new_fs_event()
				_G._matugen_theme_watcher:start(current_file_path, {}, vim.schedule_wrap(function()
					local new_spec = dofile(current_file_path)
					if new_spec and new_spec[1] and new_spec[1].config then
						new_spec[1].config()
						print("Theme reload")
					end
				end))
			end
		end
	}
}

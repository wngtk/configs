-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
	-- vim.opt.clipboard:append('unnamedplus')
	-- Fix "waiting for osc52 response from terminal" message
	-- https://github.com/neovim/neovim/issues/28611
	if vim.env.SSH_TTY ~= nil then
		-- Set up clipboard for ssh
		local function my_paste(_)
			return function(_)
				local content = vim.fn.getreg('"')
				return vim.split(content, '\n')
			end
		end
		vim.g.clipboard = {
			name = 'OSC 52',
			copy = {
				['+'] = require('vim.ui.clipboard.osc52').copy('+'),
				['*'] = require('vim.ui.clipboard.osc52').copy('*'),
			},
			paste = {
				-- No OSC52 paste action since wezterm doesn't support it
				-- Should still paste from nvim
				['+'] = my_paste('+'),
				['*'] = my_paste('*'),
			},
		}
	end
end)

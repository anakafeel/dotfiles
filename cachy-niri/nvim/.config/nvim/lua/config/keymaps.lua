-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Alt = niri's Super inside the terminal: Alt+HJKL / arrows move focus across
-- nvim splits and tmux panes alike. Overrides LazyVim's normal-mode Alt+J/K
-- line moving (still works in visual mode on a selection).
local nav = {
  h = "TmuxNavigateLeft", j = "TmuxNavigateDown", k = "TmuxNavigateUp", l = "TmuxNavigateRight",
  Left = "TmuxNavigateLeft", Down = "TmuxNavigateDown", Up = "TmuxNavigateUp", Right = "TmuxNavigateRight",
}
for key, cmd in pairs(nav) do
  vim.keymap.set("n", "<A-" .. key .. ">", "<cmd>" .. cmd .. "<cr>", { desc = cmd })
end

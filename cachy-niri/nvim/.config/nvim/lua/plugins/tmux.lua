-- Seamless Alt+HJKL / Alt+arrows between nvim splits and tmux panes
-- (tmux side lives in ~/.config/tmux/tmux.conf). Mappings are in config/keymaps.lua.
return {
  {
    "christoomey/vim-tmux-navigator",
    cmd = { "TmuxNavigateLeft", "TmuxNavigateDown", "TmuxNavigateUp", "TmuxNavigateRight" },
    init = function()
      vim.g.tmux_navigator_no_mappings = 1
    end,
  },
}

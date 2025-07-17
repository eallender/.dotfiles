-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Launch WSL (replace 'Ubuntu' with your distro if needed)
config.wsl_domains = {
    {
        name = "WSL:Ubuntu-20.04", -- A custom name for this domain in Wezterm
        distribution = "Ubuntu-20.04", -- The actual name of your WSL distro from 'wsl -l -v'
        -- Optional: Specify a default current working directory *within WSL*
        -- "~" is typically the home directory of the default WSL user.
        -- You can also specify an absolute path like "/home/youruser/projects"
        default_cwd = "/home/evan",
        -- Optional: If you use a different shell than the default for that user
        -- default_prog = {"fish", "-l"},
    },
}
config.default_domain = "WSL:Ubuntu-20.04"

-- UI window
config.enable_tab_bar = true
config.initial_cols = 120
config.initial_rows = 28
config.font_size = 11
config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font("MesloLGS Nerd Font Mono")

-- Key bindings
config.keys = {
    -- Ctrl+C: ALWAYS copies if there's a selection.
    -- If no selection, it does nothing and does NOT send ^C to the terminal.
    -- This means Ctrl+C will *never* send ^C to your terminal directly via this binding.
    {
        key = "c",
        mods = "CTRL",
        action = wezterm.action.CopyTo("ClipboardAndPrimarySelection"),
    },
    -- Ctrl+Shift+C: Sends a literal ^C to the terminal.
    -- Use this for interrupting processes.
    {
        key = "C", -- Note: Capital 'C' because Shift is pressed
        mods = "CTRL|SHIFT",
        action = wezterm.action.SendKey({ key = "c", mods = "CTRL" }),
    },
    -- Ctrl+V: Pastes from clipboard.
    {
        key = "v",
        mods = "CTRL",
        action = wezterm.action.PasteFrom("Clipboard"),
    },
    -- Navigation between panes (left)
    {
        key = "LeftArrow", mods = "CTRL", action = act.ActivateTabRelative(-1),
    },
    -- Navigation between panes (right)
    {
        key = "RightArrow", mods = "CTRL", action = act.ActivateTabRelative(1),
    },
    -- Spawn a new tab
    {
        key = "UpArrow",
        mods = "CTRL",
        action = act.SpawnTab("CurrentPaneDomain"),
    },
    -- Delete current tab
    {
        key = "DownArrow",
        mods = "CTRL",
        action = act.CloseCurrentPane{confirm=false},
    },
}

return config

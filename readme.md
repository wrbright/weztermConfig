## TMUX inspired keybindings, Powerline inspired tabbar
Loose initial config, still some work to do. Assumes nightly build and will break with stable version, this is on purpose

### Some things to note

- All standard keybindings have been disabled, on purpose
    - Keybindings can be found in keybindings.lua
    - currently support for copy mode, quick resizing, window select, attaching and detaching, window selection, domain, pane selection, and a few others are not yet implemented in this config. They can be accessed in the quick menu however with **[ctrl+.]**
- Currently, Wezterm the application is broken on wayland for Nvidia Graphics Cards. This is a known issue however is not currently being worked on. I blame Nvidia. Wayland support is thus disabled

### What it looks like
![image](https://user-images.githubusercontent.com/55282244/226798069-4d326395-9385-4e52-b940-6dcf02005deb.png)
My alterations on an aesthetic level are the usage of the gruvbox colorscheme and the tabline, opacity, which has been manually altered

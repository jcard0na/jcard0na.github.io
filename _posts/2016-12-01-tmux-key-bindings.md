---
layout: post
title: tmux key bindings
---
I keep changing between mac and linux, and all is cool except that I realized
I'm really clumsy at managing multiple terminal windows.  On linux I've
been using gnome-terminal, and the hotkeys `Alt-1`, `Alt-2`, etc. to switch
between them.

On Mac that is not available, and I remapped `Cmd-[` and `Cmd-]` to navigate
around terminals.

It looks like tmux is what I want, a newer terminal multiplexer that seems to
have overshadowed GNU-screen.

After a quick test ride, this looks like it would work for me in giving a
unified multi-terminal interface across platforms.  Works out of the box on Mac
(brew) and Linux.

Except that the keystrokes to switch between terminals are not that
hand-friendly: `Ctrl-B, 0`, `Ctrl-B, 1`, ... hard to type without looking at
the keyboard.

The following `~/.tmux.conf` will change the default prefix to `Ctrl-A` (much
easier to type with one hand), and the window enumeration to start from 1, so
you don't need to jump across the keyboard to hit that zero.

```
# remap prefix to Control + a
set -g prefix C-a
# bind 'C-a C-a' to type 'C-a'
bind C-a send-prefix
unbind C-b
# Start windows and panes at 1, not 0
set -g base-index 1
setw -g pane-base-index 1
```

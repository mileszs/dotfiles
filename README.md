# Mah Dotfilez #

My collection of configuration files (zshrc, tmux, kitty, ghostty, etc.). Most of these things I have collected from various people smarter than me over the years. Feel free to use anything you find useful.

Runs on macOS and on Linux, including headless boxes you only ever reach over SSH.

## Installation ##

    git clone https://github.com/mileszs/dotfiles.git ~/code/dotfiles
    cd ~/code/dotfiles
    ./install

`install` is plain bash (no Ruby needed), and it is safe to re-run — existing
links are left alone and anything unexpected is reported rather than clobbered.

It will:

1. Install the tools these configs expect, via `apt` on Linux or `brew` on macOS.
2. Clone oh-my-zsh plus `zsh-autosuggestions` and `zsh-syntax-highlighting`.
3. Symlink everything into `$HOME` and `~/.config`.

### Options ###

| Flag | Effect |
| --- | --- |
| `--no-packages` | Skip the package manager step; just link and bootstrap zsh. |
| `--headless` | Don't link the GUI terminal configs (kitty, ghostty). |
| `--gui` | Do link them, even if no display is detected. |
| `--force` | Back up whatever is in the way (to `<name>.backup-<timestamp>`) and relink. |
| `--dry-run` | Print what would happen without touching anything. |

Headless is detected automatically on Linux: no `$DISPLAY` and no
`$WAYLAND_DISPLAY` means the kitty and ghostty configs are skipped.

## Per-machine settings ##

Nothing machine-specific belongs in this repo. Three escape hatches, none of
them tracked:

- `~/.zshrc.local` — sourced last by `zshrc`.
- `~/.zsh/local.sh` and `~/.zsh/work.sh` — picked up with the rest of `~/.zsh/*.sh`.
- `~/.gitconfig.local` — `include`d by `gitconfig`, for a work email or signing key.

## Clipboard ##

`bin/clipcopy` and `bin/clippaste` figure out at runtime what the clipboard
actually is: `pbcopy` on macOS, `wl-copy` or `xclip` on a Linux desktop, and on
a headless box the tmux buffer or an OSC 52 escape sequence. That last one is
the useful bit over SSH — yanking in tmux on a remote machine lands the text in
the clipboard of the terminal in front of you.

The zsh global alias `C` (as in `some-command C`) and tmux's copy-mode `y` both
route through it.

## Terminfo over SSH ##

SSH forwards `TERM` but not the terminfo entry behind it, so a server whose
ncurses has never heard of `xterm-ghostty` falls back to something dumb and
starts drawing garbage while you type. `bin/ssh-terminfo` fixes that one host
at a time, run from the machine you are sitting at:

    ssh-terminfo beorn

It pipes the local entry for `$TERM` through `tic` on the far end, into
`~/.terminfo`. Once per host is enough. Set `TERMINFO_NAME` to send some entry
other than the current `$TERM`.

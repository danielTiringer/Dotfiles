# Dotfiles and system setup scripts

A collection of my actively used dotfiles and a set of install scripts that helps me reproduce the same system on a new machine.

## Usage

### System install

Currently, the following list is implemented:
- Alpine (from an extended image)
- Arch   (mainline, basic install)
- Debian (server install with only basic system utilities)
- Void   (base install with glibc (would probably work with musl too))
- MacOS

The following are expected to exist:
- `git` installed
- `sudo` installed
- a user is already set up and has `sudo` access

Run `./bootstrap.sh`

### Dotfiles

The dotfiles in this repo get symlinked to their location on the system when the  `./stow_linux` or `./stow_mac` scripts are executed.
Some of the dotfiles are not in their "original" location and the programs are guided to them by the environmental variables set in the `zsh` config.

## Resources

- [Nerd Font icon lookup](https://www.nerdfonts.com/cheat-sheet)

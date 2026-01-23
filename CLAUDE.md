# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

Personal dotfiles repository managing configurations for 40+ tools across Arch Linux and macOS. Uses a modular architecture where each tool has its own directory with a `setup.sh` script.

## Commands

### Install a module
```bash
./install <module> [module...]
# Examples:
./install vim tmux
./install zsh git sdk/rust
```

### Full Arch Linux setup
```bash
./arch/setup.sh  # Requires sudo, runs multi-stage setup
```

### Sync Neovim plugins
```bash
nvim --headless "+Lazy! sync" +qa
```

### Sync tmux plugins
```bash
~/.tmux/plugins/tpm/scripts/install_plugins.sh
```

## Architecture

### Module Pattern
Each module follows this structure:
```
<module>/
├── setup.sh          # Creates symlinks to ~/.config/ or ~/
└── config files      # Tool-specific configs
```

Setup scripts use `ln -sf` / `ln -snf` to symlink configs to standard locations.

### Key Modules
- **vim/** - Neovim config using LazyVim framework (`~/.config/nvim`)
- **zsh/** - Zsh with sheldon plugin manager and starship prompt
- **tmux/** - Tmux with TPM plugin manager
- **git/** - Git config with delta pager, GPG signing, pre-commit hooks
- **hyprland/** - Hyprland compositor with waybar, fuzzel
- **sdk/** - Language SDKs (rust, python, node, go, etc.)
- **arch/** - Full Arch Linux system setup orchestrator

### Plugin Managers
- **Neovim**: Lazy.nvim
- **Zsh**: Sheldon
- **Tmux**: TPM (Tmux Plugin Manager)

### Encryption
Uses git-crypt for secrets. Encrypted files defined in `.gitattributes`:
- `*.pvt` files
- `zsh/zsh_secret`

Use `git lock` / `git unlock` aliases to manage encryption.

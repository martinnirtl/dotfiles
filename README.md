# Dotfiles

Run the following command to initialize the macOS system using this repository based on `chezmoi` (`chezmoi` will be installed via Brew). No git-cloning required, just run the command and everything will be in place:

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/martinnirtl/dotfiles/main/setup.sh)"
```

The final instruction of initialization script will run `chezmoi apply` to apply everything else defined within this repo.

## Updater Scripts

Updater scripts are there to keep important toolchains up2date. These scripts are run after confirmation during `chezmoi apply` and are there for Brew formulas, Cilium CLI, Golang and Rust (aws CLI is currently in backlog).
After one week without `chezmoi apply`, a prompt will ask to run it in order to also run updater scripts (see `run_updater.sh`).

## Other

Shell Text Generators
- Currently used: https://edukits.co/text-art/ (Font: Pagga)
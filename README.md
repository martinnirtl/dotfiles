# Dotfiles

Run the following command to initialize the macOS system using this repository based on `chezmoi` (`chezmoi` will be installed via Brew). No git-cloning required, just run the command and everything will be in place:

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/martinnirtl/dotfiles/main/init.sh)"
```

The final instruction of initialization script will run `chezmoi apply` to apply everything else defined within this repo.

## Checker Scripts

Checker scripts are there to keep the most important toolchains up2date. Currently, they run on every `chezmoi apply` and are there for aws CLI, all Brew formulas, Golang and Rust.
After one week without `chezmoi apply`, a prompt will ask to run it in order to also run checker scripts (see `run_checker-*.sh`).

## Other

Shell Text Generators
- Currently used: https://edukits.co/text-art/ (Font: Pagga)
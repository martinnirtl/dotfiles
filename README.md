# Dotfiles

Run the following command to initialize the macOS system using this repository based on `chezmoi` (`chezmoi` will be installed via Brew). No git-cloning required, just run the command and everything will be in place:

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/martinnirtl/dotfiles/main/init.sh)"
```

The final instruction of initialization script will run `chezmoi apply` to apply everything else defined within this repo.

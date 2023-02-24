# Dotfiles

Run the following command to initialize the macOS system using this repository based on `chezmoi`. No git-cloning required, just run the command:

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/martinnirtl/dotfiles/main/init.sh)"
```

The final instruction of initialization will run `chezmoi apply` to install everything else defined within this repo.
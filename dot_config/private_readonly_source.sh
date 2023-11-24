# COLLECTION OF TO-BE-SOURCED

# 1PASSWORD PLUGINS (https://developer.1password.com/docs/cli/shell-plugins/)
if [ -d "$HOME/.config/op" ]; # checking the default install dir
then
  source $HOME/.config/op/plugins.sh
fi

# GCLOUD CLI
if [ -d "$GCLOUD_INSTALL" ]; # checking the default install dir
then
  source "$GCLOUD_INSTALL/completion.zsh.inc"
  source "$GCLOUD_INSTALL/path.zsh.inc"
fi

# Installs bitwarden cli binary

BW_CLI_LOCATION="$HOME/.local/bin/bw"
LATEST_BITWARDEN_CLI_VERSION=$(curl --silent https://api.github.com/repos/bitwarden/cli/releases/latest | jq .name --raw-output | cut -d ' ' -f2)
BITWARDEN_URI="https://github.com/bitwarden/cli/releases/download/v$LATEST_BITWARDEN_CLI_VERSION/bw-linux-$LATEST_BITWARDEN_CLI_VERSION.zip"

curl --fail --location "$BITWARDEN_URI" --output $HOME/Downloads/bitwarden.zip
unzip $HOME/Downloads/bitwarden.zip -d $HOME/.local/bin/
sudo chmod +x $BW_CLI_LOCATION

rm $HOME/Downloads/bitwarden.zip

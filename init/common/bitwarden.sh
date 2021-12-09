# Installs bitwarden binary

BITWARDEN_VERSION=1.20.0
BITWARDEN_URI="https://github.com/bitwarden/cli/releases/download/v$BITWARDEN_VERSION/bw-linux-$BITWARDEN_VERSION.zip"
echo $BITWARDEN_URI
curl --fail --silent --show-error --location "$BITWARDEN_URI" --output $HOME/Downloads/bitwarden.zip
unzip $HOME/Downloads/bitwarden.zip -d $HOME/.local/bin/
sudo chmod +x $HOME/.local/bin/bw

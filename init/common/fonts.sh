#!/bin/sh
# Installs fonts from non-distro-specific sources

# Nerd fonts
mkdir -p "$HOME"/.local/share/fonts

NERD_FONTS="DejaVuSansMono JetBrainsMono Mononoki UbuntuMono"
NERD_FONT_RELEASE="v2.1.0"

set -f; IFS=' '

for FONT in $NERD_FONTS; do
    set +f; unset IFS
    curl --fail --silent --show-error --location "https://github.com/ryanoasis/nerd-fonts/releases/download/$NERD_FONT_RELEASE/$FONT.zip" --output "$HOME/Downloads/$FONT.zip"
    unzip "$HOME/Downloads/$FONT".zip -d "$HOME"/.local/share/fonts/
    rm -rf "$HOME/Downloads/$FONT.zip"
done

set +f; unset IFS

# Powerline Fonts
git clone https://github.com/powerline/fonts.git --depth=1 "$HOME"/Downloads/fonts
sh "$HOME"/Downloads/fonts/install.sh
rm -rf "$HOME"/Downloads/fonts

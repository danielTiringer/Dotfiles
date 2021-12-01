# Installs fonts from non-distro-specific sources

FONTS=(
    "UbuntuMono"
    "DejaVuSansMono"
)

for FONT in "${FONTS[@]}"; do
    curl --fail --silent --show-error --location "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/${FONT}.zip" --output "$HOME/Downloads/${FONT}.zip"
    unzip "$HOME/Downloads/${FONT}".zip -d $HOME/.local/share/fonts/
    rm -rf "$HOME/Downloads/${FONT}.zip"
done

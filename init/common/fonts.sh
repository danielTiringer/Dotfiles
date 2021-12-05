# Installs fonts from non-distro-specific sources

# Nerd fonts
NERD_FONTS=(
    # "DejaVuSansMono"
    "JetBrainsMono"
    "Mononoki"
    # "UbuntuMono"
)

for FONT in "${NERD_FONTS[@]}"; do
    curl --fail --silent --show-error --location "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/${FONT}.zip" --output "$HOME/Downloads/${FONT}.zip"
    unzip "$HOME/Downloads/${FONT}".zip -d $HOME/.local/share/fonts/
    rm -rf "$HOME/Downloads/${FONT}.zip"
done

# Powerline Fonts
git clone https://github.com/powerline/fonts.git --depth=1 $HOME/Downloads/fonts
sh $HOME/Downloads/fonts/install.sh
rm -rf $HOME/Downloads/fonts

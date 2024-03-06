#Plugs
mkdir -p ~/.config/nvim
cp -r -n src/nvim/* ~/.config/nvim/
#Font
curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/NerdFontsSymbolsOnly.zip
unzip NerdFontsSymbolsOnly.zip -d Font
mkdir -p ~/.fonts
cp Font/*.ttf ~/.fonts/
fc-cache -f -v ~/.fonts
rm -rf Font
rm NerdFontsSymbolsOnly.zip
    
mv nvim ~/


#Plugs Suite
nvim -c ':PlugInstall' -c ':q' -c ':q'
nvim -c ':MasonInstall rust-analyzer'

if [ -n "$BASH_VERSION" ]; then
    echo "nvim=''" >> ~/.bashrc
    source ~/.bashrc
    echo "Alias défini pour Bash."
# Vérifie si le shell est Zsh
elif [ -n "$ZSH_VERSION" ]; then
    # Si le shell est Zsh, définit l'alias dans le fichier .zshrc
    echo "alias mon_alias='commande'" >> ~/.zshrc
    source ~/.zshrc
    echo "Alias défini pour Zsh."
else
    echo "Shell non pris en charge."
fi


#Plugs

mv src/vim/* ~/.vim/


#Plugs Suite
#nvim -c ':PlugInstall' -c ':q' -c ':q'
#nvim -c ':MasonInstall rust-analyzer'

if [ -n "$BASH_VERSION" ]; then
    #echo "nvim=''" >> ~/.bashrc
    #source ~/.bashrc
    #echo "Alias défini pour Bash."
# Vérifie si le shell est Zsh
elif [ -n "$ZSH_VERSION" ]; then
    # Si le shell est Zsh, définit l'alias dans le fichier .zshrc
    echo "alias mon_alias='commande'" >> ~/.zshrc
    source ~/.zshrc
    echo "Alias défini pour Zsh."
else
    echo "Shell non pris en charge."
fi


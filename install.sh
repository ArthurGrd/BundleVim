if command -v nvim &> /dev/null
then
    mv src/vim/* ~/.config/nvim/
    mv init.vim ~/.config/nvim/

    curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/NerdFontsSymbolsOnly.zip
    unzip NerdFontsSymbolsOnly.zip -d Font
    mkdir -p ~/.fonts
    cp Font/*.ttf ~/.fonts/
    fc-cache -f -v ~/.fonts
    rm -rf Font
    rm NerdFontsSymbolsOnly.zip
else
    mv src/vim/* ~/.vim/
    mv .vimrc ~/
fi

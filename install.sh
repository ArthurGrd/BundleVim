if command -v nvim &> /dev/null
then
    #Plugs
    #curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
       #https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    cp -r -n vim/* ~/.config/nvim/
    cp vim/init.vim ~/.config/nvim/init.vim
    #mkdir -p ~/.config/nvim/autoload
    #curl -LSso ~/.config/nvim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

    #Font
    curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/NerdFontsSymbolsOnly.zip
    unzip NerdFontsSymbolsOnly.zip -d Font
    mkdir -p ~/.fonts
    cp Font/*.ttf ~/.fonts/
    fc-cache -f -v ~/.fonts
    rm -rf Font
    rm NerdFontsSymbolsOnly.zip
    
    #Plugs Suite
    nvim -c ':PlugInstall' -c ':q' -c ':q'

    #YCM
    #curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    #~/.local/share/nvim/plugged/YouCompleteMe/install.py
    #cp -r third_party/ ~/.local/share/nvim/plugged/YouCompleteMe/third_party
    #cp -r rls/ ~/.local/share/nvim/plugged/YouCompleteMe/third_party/ycmd/third_party/
    #./install.py --rust-completer
    #RUSTUP_HOME=~/rusttmp
    #rustup toolchain install nightly
    #rustup default nightly
    #rustup component add rls rust-analysis rust-src
    #cd $RUSTUP_HOME/toolchains
    #cd nightly-*/
    #mv * ~/.local/share/nvim/plugged/YouCompleteMe/third_party/ycmd/third_party/rls/
    #rm -rf $RUSTUP_HOME

    # Rajouter plugin rust/ sur la version de python

else
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    cp -r -n vim/* ~/.vim/
    cp vim/init.vim ~/.vim/init.vim
    curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/NerdFontsSymbolsOnly.zip
    unzip NerdFontsSymbolsOnly.zip -d Font
    mkdir -p ~/.fonts
    cp Font/*.ttf ~/.fonts/
    fc-cache -f -v ~/.fonts
    rm -rf Font
    rm NerdFontsSymbolsOnly.zip
    vim -c ':PlugInstall' -c ':q' -c ':q'
    cd ~/.vim/plugged/YouCompleteMe/
    ./install.py --rust-completer

fi


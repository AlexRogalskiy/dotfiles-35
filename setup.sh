mkdir -p ~/.ssh
mkdir -p ~/.pip

FILES=(
    .vimrc
    .zshrc
    .pip/pip.conf
    .gitconfig
    .tmux.conf
    .ssh/config
    .Brewfile
    .Brewfile.lock.json
)

echo "Making dotfile links..."
for FILE in ${FILES[@]}
do
    ln -sfv ~/.dotfiles/$FILE ~/$FILE;
done

echo "Link vim..."
ln -sfvn ~/.dotfiles/.vim ~/.vim
ln -sfvn ~/.dotfiles/.vim ~/.config/nvim

if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Installing brewfile dependencies"
brew bundle -v --global

if [ ! -d ~/.oh-my-zsh ]; then
    echo "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

rm -rf ~/.oh-my-zsh/custom
ln -sfvn ~/.dotfiles/.oh-my-zsh ~/.oh-my-zsh/custom

echo "Syncing submodule..."
git submodule init
git submodule update --init --recursive

echo "Dump brew dependencies..."
brew bundle dump --global -f

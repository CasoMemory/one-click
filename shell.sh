# confirm system type
sys=`uname -a`

mac="Darwin"
linux="Linux"
empty_str=""


install() {
    # install nvm
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

    # make the nvm command active
    source ~/.nvm/nvm.sh

    checkNVM=`command -v nvm`

    # install node
    if [[ $checkNVM = "nvm" ]]; then
        nvm install --lts
    fi

    nvm use --lts

    nv=`nvm -v`
    nov=`node -v`

    echo "nvm verison is ${nv}, node version is ${nov}"

    # install omz
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    echo "Congratulations! All tools installed"

    source ~/.zshrc
}

if [[ $sys =~ $mac ]]; then
    xcode-select --install

    # install homebrew
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    # execute
    install
elif [[ $sys =~ $linux ]]; then
    echo "your laptop OS is $sys, start to execute the shell"
    yum install -y git

    check_sudo=`command -v sudo`
    check_chsh=`command -v chsh`
    check_zsh=`command -v zsh`

    # install sudo
    if [[ $check_sudo = "" ]]; then
        yum install sudo -y
    fi

    # install chsh
    if [[ $check_chsh = "" ]]; then
        yum install util-linux-user
    fi

    # install zsh
    if [[ $check_chsh = "" ]]; then
        yum install zsh -y
    fi

    chsh -s /usr/bin/zsh

    zsh

    # execute
    install
else
    echo "your laptop OS is $sys"
fi


FROM archlinux:latest

RUN echo -e '[archlinuxcn]\nServer = https://repo.archlinuxcn.org/$arch' >> /etc/pacman.conf && \
    ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    pacman-key --init && \
    # workaround https://bbs.archlinuxcn.org/viewtopic.php?id=13906
    pacman-key --lsign farseerfc@archlinux.org && \
    pacman --noconfirm -Sy && \
    pacman --noconfirm -S archlinuxcn-keyring && \
    pacman --noconfirm -S sudo paru && \
    paru -Syu --noconfirm

RUN paru --noconfirm -S \
    base-devel \
    git python-pre-commit git-delta git-crypt \
    wget curl axel \
    neovim \
    zsh sheldon starship \
    tmux \
    fd \
    jq \
    fzf \
    zoxide \
    sd \
    ripgrep \
    eza \
    bat \
    net-tools

RUN paru --noconfirm -S \
    linux-tools-meta \
    go \
    nodejs npm \
    duf \
    dua-cli \
    hyperfine \
    fastfetch \
    onefetch \
    bottom \
    csview-git \
    code-minimap-git \
    yazi

# dotfiles
COPY . /root/dotfiles
RUN ~/dotfiles/install zsh
SHELL ["/usr/bin/zsh", "-c"]
RUN ~/dotfiles/install bin git vim tmux bat fd sdk/rust

# Post-install
RUN paru -Sc --noconfirm && \
    rm -rf ~/.cache/* ~/.cargo/git ~/.cargo/registry && \
    mkdir ~/work

WORKDIR /root/work

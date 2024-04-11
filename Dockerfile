FROM archlinux:latest

RUN 

RUN echo -e '[archlinuxcn]\nServer = https://repo.archlinuxcn.org/$arch' >> /etc/pacman.conf && \
    ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    pacman-key --init && \
    # workaround https://bbs.archlinuxcn.org/viewtopic.php?id=13906
    pacman-key --lsign farseerfc@archlinux.org && \
    pacman --noconfirm -Sy && \
    pacman --noconfirm -S archlinuxcn-keyring && \
    # workaround https://www.reddit.com/r/EndeavourOS/comments/1be08gg/yay_paru_broken_cant_do_anything_with_them_even/
    ln -s /usr/lib/libalpm.so.14.0.0 /usr/lib/libalpm.so.13 && \
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
    exa \
    bat \
    shellcheck-static \
    net-tools dstat gping

RUN paru --noconfirm -S \
    linux-tools-meta \
    go \
    rustup \
    nodejs npm \
    duf \
    dua-cli \
    hyperfine \
    neofetch \
    onefetch \
    bottom \
    mmv-go \
    csview-git \
    code-minimap-git \
    clitrans-git

# dotfiles
ADD . /root/dotfiles
RUN ~/dotfiles/install zsh
SHELL ["/usr/bin/zsh", "-c"]
RUN ~/dotfiles/install bin git vim tmux bat fd

# rust
RUN rustup toolchain install nightly --component \
    rust-std \
    rustfmt \
    clippy

# Post-install
RUN paru -Sc --noconfirm && \
    rm -rf ~/.cache/* ~/.cargo/git ~/.cargo/registry && \
    mkdir ~/work

WORKDIR /root/work

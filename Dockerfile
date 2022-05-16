FROM archlinux:latest

RUN echo -e '[archlinuxcn]\nServer = https://repo.archlinuxcn.org/$arch' >> /etc/pacman.conf && \
        ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
        pacman-key --init && \
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

## About
配置文件库

## Screenshot

### ZSH

![](http://oodrq1zte.bkt.clouddn.com/2017-04-14-zsh.png)

### Tmux

![](http://oodrq1zte.bkt.clouddn.com/2017-04-14-tmux.png)

### Vim

- Config & Plugins

![](http://oodrq1zte.bkt.clouddn.com/2017-04-14-vim-config.png)

- C++

![](http://oodrq1zte.bkt.clouddn.com/2017-04-14-vim-cpp.png)

## How To Use

``` bash
git clone https://github.com/wfxr/dotfiles
cd dotfiles
```

- Restore common configurations:

``` bash
./restore_common_config.sh
```

- Restore all configurations:

``` bash
./restore_config.sh
```

- Restore specified configuration(s):

``` bash
  # eg: restore zsh, tmux and vim
  ./restore_config.sh zsh tmux vim
```

## License

[MIT](LICENSE.txt)

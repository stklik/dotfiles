# Dotfiles

It was about time I started using these... As most people, I have also shamelessly copied, adapted and merged ideas and code from various people.

Not sure if what I do is maintainable, but it works for me. Use at your own risk.


# Install

**Install only dotfiles**
```
bash -c "$(curl -fsSL https://raw.github.com/stklik/dotfiles/master/dotinstall)"
```

**Display help (add `sh help`)**
```
bash -c "$(curl -fsSL https://raw.github.com/stklik/dotfiles/master/dotinstall)" sh "help"
```

**Full installation, including software packages and OS config**
```
bash -c "$(curl -fsSL https://raw.github.com/stklik/dotfiles/master/dotinstall)" sh "full"
```

**Update (i.e. re-download) this repo**
```
bash -c "$(curl -fsSL https://raw.github.com/stklik/dotfiles/master/dotinstall)" sh "update"
```

**Update & full install**
```
bash -c "$(curl -fsSL https://raw.github.com/stklik/dotfiles/master/dotinstall)" sh "update" "full"
```


# ToDo

- [ ] VLC settings (vlcrc)
- [ ] Default apps for file types on Mac
- [ ] Symlink files instead of copy

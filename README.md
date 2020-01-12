# Dotfiles

It was about time I started using these... As most people, I have also shamelessly copied, adapted and merged ideas and code from various people.

Not sure if what I do is maintainable, but it works for me. Use at your own risk.


# Install

**Install only dotfiles**
```
sh -c "$(curl -fsSL https://raw.github.com/stklik/dotfiles/master/dotinstall)"
```

**Display help (add `sh help`)**
```
sh -c "$(curl -fsSL https://raw.github.com/stklik/dotfiles/master/dotinstall)" sh "help"
```

**Full installation, including software packages and OS config**
```
sh -c "$(curl -fsSL https://raw.github.com/stklik/dotfiles/master/dotinstall)" sh "full"
```

**Update (i.e. re-download) this repo**
```
sh -c "$(curl -fsSL https://raw.github.com/stklik/dotfiles/master/dotinstall)" sh "update"
```

**Update & full install**
```
sh -c "$(curl -fsSL https://raw.github.com/stklik/dotfiles/master/dotinstall)" sh "update" "full"
```

# Vim GitHub Co Author Plugin
![image](use-sample.gif)

## Installation
Using [vim-plug](https://github.com/junegunn/vim-plug)
``` vimscript
Plug 'jehuipark/github-co-author-vim-plugin'
```

## Use Guide

### Co-Author complete shortcut key
when insert mode in vi

`ctrl` + `l`

### Global Config
**Co Author Global Management File Path**
``` vim
let g:github_co_author_list_path = '~/.vim/github-co-author-list'
```

### Local Config
**Co Author Local Management File Path**

`{git_work_space}/.git_author`  
![image](git_author_local_config_path.png)

### Co Author Management File Format
```
alias1 name1 email1
alias2 name2 email2
alias3 name3 email3
```

### Auto Complete Flow
1. keymap
1. hasLocal? return : next
1. hasGlobal? return : next
1. fallback return 
    > fallback message: `Co-Authored-By: name <email>`

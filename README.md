# ~/.config/nvim
git clone --depth=1 https://github.com/hbsea/nvimrc.git ~/.config/nvim

# ~/.tmux.conf
```
cat > ~/.tmux.conf <<'EOF'
bind -n F12 if -F '#{==:#{@keys_disabled},1}' \
  'set -g prefix C-b; set -g status-left ""; set -g @keys_disabled 0; display "✅"' \
  'set -g prefix None; set -g status-left ""; set -g @keys_disabled 1; display "🚫"'

set -g mouse on
set -g set-clipboard on
set -g status off
EOF
```

# ~/.bashrc
```
// 1. 禁用终端驱动对 Ctrl+W 的默认捕获
stty werase undef

// 2. 将 Ctrl+W 绑定到识别斜杠的删除动作
bind '\C-w: unix-filename-rubout'

```

# ~/.zshrc
```
// 1.install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
// 2.plugins
git clone https://github.com/marlonrichert/zsh-autocomplete ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autocomplete
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
// 3.enable in zshrc
plugins=(git zsh-autocomplete zsh-autosuggestions)
```

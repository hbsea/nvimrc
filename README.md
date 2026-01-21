# ~/.config/nvim
git clone --depth=1 https://github.com/hbsea/nvimrc.git ~/.config/nvim


# ~/.tmux.conf
```
cat > ~/.tmux.conf <<'EOF'
bind-key -n F4 kill-pane
bind -n F12 if -F '#{==:#{@keys_disabled},1}' \
  'set -g prefix C-b; set -g status-left ""; set -g @keys_disabled 0; display "✅"' \
  'set -g prefix None; set -g status-left "[OFF]"; set -g @keys_disabled 1; display "🚫"'

set -g default-terminal "tmux-256color"
set -ga terminal-overrides ",xterm-kitty:Tc"
set -g mouse on
set -g allow-passthrough on
set -g status off
EOF
```
tmux source-file ~/.tmux.conf


# ~/.config/kitty/kitty.conf
# kitty +list-fonts
# kitty +kitten themes
```
font_size 16.0
macos_option_as_alt yes
clear_all_shortcuts yes
allow_remote_control yes
map cmd+v paste_from_clipboard
map cmd+c copy_or_noop
map ctrl+cmd+, load_config_file
map cmd+n new_os_window
map cmd+, edit_config_file
```

# ~/.bashrc
#  1. 禁用终端驱动对 Ctrl+W 的默认捕获
stty werase undef

# 2. 将 Ctrl+W 绑定到识别斜杠的删除动作
bind '\C-w: unix-filename-rubout'



# nvimrc
git clone --depth=1 https://github.com/hbsea/nvimrc.git ~/.config/nvim

cat > ~/.tmux.conf <<'EOF'
bind-key -n F9 kill-pane
bind -n F12 if -F '#{==:#{@keys_disabled},1}' \
  'set -g prefix C-b; set -g status-left ""; set -g @keys_disabled 0; display "✅ Key bindings enabled"' \
  'set -g prefix None; set -g status-left "[KEYS OFF]"; set -g @keys_disabled 1; display "🚫 Key bindings disabled"'
EOF

tmux source-file ~/.tmux.conf

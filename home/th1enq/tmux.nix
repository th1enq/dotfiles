{ ... }:

{
  programs.tmux = {
    enable = true;

    mouse = true;
    keyMode = "vi";
    terminal = "tmux-256color";

    baseIndex = 1;
    escapeTime = 10;
    historyLimit = 100000;

    extraConfig = ''
      # Renumber windows automatically after one is closed.
      set-option -g renumber-windows on

      # Enable true-color support.
      set-option -sa terminal-features ',xterm-256color:RGB'

      # Split panes in the current working directory.
      bind-key '"' split-window -v -c '#{pane_current_path}'
      bind-key % split-window -h -c '#{pane_current_path}'

      # Reload this configuration with Prefix + r.
      bind-key r source-file ~/.config/tmux/tmux.conf \; display-message "tmux config reloaded"
    '';
  };
}

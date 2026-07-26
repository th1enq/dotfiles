{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    shellAliases = {
      "btw" = "echo I use nixos, btw";
      "rebuild" = "sudo nixos-rebuild switch --flake /etc/nixos#laptop";
      "build-config" = "nixos-rebuild build --flake /etc/nixos#laptop";
      "config" = "sudo nvim /etc/nixos";
      cat = "bat --theme=base16";
      ls = "eza --icons=always --color=always -a";
      ll = "eza --icons=always --color=always -la";
      f = "fzf";
      fp = "fzf --preview=\"bat --color=always {}\"";
      see = "kitten icat";
      neovide = "command neovide --fork";
      nix_clean = "sudo nix-collect-garbage -d";
    };
    autosuggestion.enable = true;

    plugins = [
      {
        name = "zsh-history-substring-search";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-history-substring-search";
          rev = "v1.1.0";
          sha256 = "sha256-GSEvgvgWi1rrsgikTzDXokHTROoyPRlU0FVpAoEmXG4=";
        };
        file = "zsh-history-substring-search.zsh";
      }

      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.8.0";
          sha256 = "sha256-iJdWopZwHpSyYl5/FQXEW7gl/SrKaYDEtTH9cGP7iPo=";
        };
        file = "zsh-syntax-highlighting.zsh";
      }
    ];
    history = {
      path = "$HOME/.config/zsh/zhistory";
      size = 5000;
      save = 5000;

      ignoreDups = true;
      ignoreAllDups = true;
      ignoreSpace = true;
      saveNoDups = true;
      findNoDups = true;
      expireDuplicatesFirst = true;
      share = true;
    };

    setOptions = [
      "APPEND_HISTORY"
      "AUTO_CD"
      "PROMPT_SUBST"
      "MENU_COMPLETE"
      "LIST_PACKED"
      "AUTO_LIST"
      "COMPLETE_IN_WORD"
    ];

    enableCompletion = true;
    initContent = ''
              path=("$HOME/.local/bin" $path)
              export PATH
      		    compinit -C -d ~/.config/zsh/zcompdump
      		    autoload -Uz add-zsh-hook
      		    autoload -Uz vcs_info
      		    precmd () { vcs_info }
      		    _comp_options+=(globdots)

      		    zstyle ':completion:*' verbose true
      		    zstyle ':completion:*:*:*:*:*' menu select
      		    zstyle ':completion:*:default' list-colors ''${(s.:.)LS_COLORS} 'ma=48;5;197;1'
      		    zstyle ':completion:*' matcher-list \
      				'm:{a-zA-Z}={A-Za-z}' \
      				'+r:|[._-]=* r:|=*' \
      				'+l:|=*'
      		    zstyle ':completion:*:warnings' format "%B%F{red}No matches for:%f %F{magenta}%d%b"
      		    zstyle ':completion:*:descriptions' format '%F{yellow}[-- %d --]%f'
      		    zstyle ':vcs_info:*' formats ' %B%s-[%F{magenta}%f %F{yellow}%b%f]-'
      		    
      			expand-or-complete-with-dots() {
      			  echo -n "\e[31m…\e[0m"
      			  zle expand-or-complete
      			  zle redisplay
      			}
      			zle -N expand-or-complete-with-dots

      			bindkey "^I" expand-or-complete-with-dots
      			bindkey "^[[1;5D" backward-word
      			bindkey "^[[1;5C" forward-word
      			bindkey '^H' backward-kill-word
      		        bindkey '^[[A' history-substring-search-up
      			bindkey '^[[B' history-substring-search-down
      			bindkey '^[[3~' delete-char	

      			function dir_icon {
      			  if [[ "$PWD" == "$HOME" ]]; then
      			    echo "%B%F{cyan}%f%b"
      			  else
      			    echo "%B%F{cyan}%f%b"
      			  fi
      			}

      			PS1='%B%F{blue}%f%b  %B%F{magenta}%n%f%b $(dir_icon)  %B%F{red}%~%f%b''${vcs_info_msg_0_} %(?.%B%F{green}.%F{red})%f%b '

      			# command not found
      			command_not_found_handler() {
      				printf "%s%s? I don't know what is it\n" "$acc" "$0" >&2
      			    return 127
      			}
      			function xterm_title_precmd () {
      	print -Pn -- '\e]2;%n@%m %~\a'
      	[[ "$TERM" == 'screen'* ]] && print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\'
      }

      function xterm_title_preexec () {
      	print -Pn -- '\e]2;%n@%m %~ %# ' && print -n -- "''${(q)1}\a"
      	[[ "$TERM" == 'screen'* ]] && { print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-} %# ' && print -n -- "''${(q)1}\e\\"; }
      }

      if [[ "$TERM" == (kitty*|alacritty*|tmux*|screen*|xterm*) ]]; then
      	add-zsh-hook -Uz precmd xterm_title_precmd
      	add-zsh-hook -Uz preexec xterm_title_preexec
      fi
      echo -ne "\e[2 q"
      eval "$(direnv hook zsh)"
      		'';

  };
}

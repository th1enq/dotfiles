{ config, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = false;

    settings = [
      {
        layer = "top";
        position = "top";
        exclusive = true;
        passthrough = false;
        gtk-layer-shell = true;
        spacing = 0;
        margin-left = 0;
        margin-right = 0;
        margin-top = 0;

        modules-left = [
          "idle_inhibitor"
          "group/mobo_drawer"
          "hyprland/workspaces#rw"
          "tray"
          "mpris"
        ];
        modules-center = [
          "clock#2"
          "group/notify"
        ];
        modules-right = [
          "hyprland/window"
          "battery"
          "group/audio"
          "custom/power"
        ];

        "group/mobo_drawer" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 500;
            children-class = "cpu";
            transition-left-to-right = true;
          };
          modules = [
            "temperature"
            "cpu"
            "power-profiles-daemon"
            "memory"
            "disk"
          ];
        };

        "group/notify" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 500;
            children-class = "custom/swaync";
            transition-left-to-right = false;
          };
          modules = [
            "custom/swaync"
            "custom/dot_update"
          ];
        };

        "group/audio" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 500;
            children-class = "pulseaudio";
            transition-left-to-right = true;
          };
          modules = [
            "pulseaudio"
            "pulseaudio#microphone"
          ];
        };

        "hyprland/workspaces#rw" = {
          disable-scroll = true;
          active-only = false;
          all-outputs = true;
          warp-on-scroll = false;
          sort-by-number = true;
          show-special = false;
          on-click = "activate";
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
          persistent-workspaces = {
            "*" = 5;
          };
          format = "{icon} {windows}";
          format-window-separator = " ";
          window-rewrite-default = " ";
          window-rewrite = {
            "title<.*amazon.*>" = " ";
            "title<.*reddit.*>" = " ";
            "class<firefox|org.mozilla.firefox|librewolf|floorp|mercury-browser|[Cc]achy-browser>" = " ";
            "class<zen>" = "󰰷 ";
            "class<waterfox|waterfox-bin>" = " ";
            "class<microsoft-edge>" = " ";
            "class<Chromium|Thorium|[Cc]hrome>" = " ";
            "class<brave-browser>" = "🦁 ";
            "class<tor browser>" = " ";
            "class<firefox-developer-edition>" = "🦊 ";
            "class<kitty|konsole|[Aa]lacritty>" = " ";
            "class<kitty-dropterm>" = " ";
            "class<com.mitchellh.ghostty>" = " ";
            "class<org.wezfurlong.wezterm>" = " ";
            "class<Warp|warp|dev.warp.Warp|warp-terminal>" = "󰰭 ";
            "class<[Tt]hunderbird|[Tt]hunderbird-esr>" = " ";
            "class<eu.betterbird.Betterbird>" = " ";
            "title<.*gmail.*>" = "󰊫 ";
            "class<[Tt]elegram-desktop|org.telegram.desktop|io.github.tdesktop_x64.TDesktop>" = " ";
            "class<discord|discord-canary|[Ww]ebcord|[Vv]esktop|com.discordapp.Discord|dev.vencord.Vesktop>" = " ";
            "class<[Ss]ignal|signal-desktop|org.signal.Signal>" = "󰍩 ";
            "title<.*Signal.*>" = "󰍩 ";
            "title<.*whatsapp.*>" = " ";
            "title<.*zapzap.*>" = " ";
            "title<.*messenger.*>" = " ";
            "title<.*facebook.*>" = " ";
            "title<.*Discord.*>" = " ";
            "title<.*ChatGPT.*>" = "󰚩 ";
            "title<.*deepseek.*>" = "󰚩 ";
            "title<.*qwen.*>" = "󰚩 ";
            "class<subl>" = "󰅳 ";
            "class<slack>" = " ";
            "class<mpv>" = " ";
            "class<celluloid|Zoom>" = " ";
            "class<Cider>" = "󰎆 ";
            "title<.*Picture-in-Picture.*>" = " ";
            "title<.*youtube.*>" = " ";
            "class<vlc>" = "󰕼 ";
            "class<[Kk]denlive|org.kde.kdenlive>" = "🎬 ";
            "title<.*Kdenlive.*>" = "🎬 ";
            "title<.*cmus.*>" = " ";
            "class<[Ss]potify>" = " ";
            "class<Plex>" = "󰚺 ";
            "class<virt-manager>" = " ";
            "class<.virt-manager-wrapped>" = " ";
            "class<remote-viewer|virt-viewer>" = " ";
            "class<virtualbox manager>" = "💽 ";
            "title<virtualbox>" = "💽 ";
            "class<remmina|org.remmina.Remmina>" = "🖥️ ";
            "class<VSCode|code|code-url-handler|code-oss|codium|codium-url-handler|VSCodium>" = "󰨞 ";
            "class<dev.zed.Zed>" = "󰵁";
            "class<codeblocks>" = "󰅩 ";
            "title<.*github.*>" = " ";
            "class<mousepad>" = " ";
            "class<libreoffice-writer>" = " ";
            "class<libreoffice-startcenter>" = "󰏆 ";
            "class<libreoffice-calc>" = " ";
            "title<.*nvim ~.*>" = " ";
            "title<.*vim.*>" = " ";
            "title<.*nvim.*>" = " ";
            "title<.*figma.*>" = " ";
            "title<.*jira.*>" = " ";
            "class<jetbrains-idea>" = " ";
            "class<obs|com.obsproject.Studio>" = " ";
            "class<polkit-gnome-authentication-agent-1>" = "󰒃 ";
            "class<nwg-look>" = " ";
            "class<nwg-displays>" = " ";
            "class<[Pp]avucontrol|org.pulseaudio.pavucontrol>" = "󱡫 ";
            "class<steam>" = " ";
            "class<thunar|nemo>" = "󰝰 ";
            "class<Gparted>" = "";
            "class<gimp>" = " ";
            "class<emulator>" = "📱 ";
            "class<android-studio>" = " ";
            "class<org.pipewire.Helvum>" = "󰓃";
            "class<localsend>" = "";
            "class<PrusaSlicer|UltiMaker-Cura|OrcaSlicer>" = "󰹛";
            "class<io.github.kolunmi.Bazaar>" = " ";
            "title<^Bazaar$>" = " ";
            "class<com.gabm.satty>" = " ";
            "title<^satty$>" = " ";
            "class<[Bb]ox[Bb]uddy|io.github.dvlv.boxbuddy|io.github.dvlv.BoxBuddy>" = " ";
            "title<.*BoxBuddy.*>" = " ";
            "title<Hyprland Keybinds>" = " ";
            "title<Niri Keybinds>" = " ";
            "title<BSPWM Keybinds>" = " ";
            "title<DWM Keybinds>" = " ";
            "title<Emacs Leader Keybinds>" = " ";
            "title<Kitty Configuration>" = " ";
            "title<WezTerm Configuration>" = " ";
            "title<Yazi Configuration>" = " ";
            "title<Cheatsheets Viewer>" = " ";
            "title<Documentation Viewer>" = " ";
            "title<^Wallpapers$>" = " ";
            "title<^Video Wallpapers$>" = " ";
            "title<^qs-wlogout$>" = " ";
          };
        };

        "hyprland/window" = {
          format = "{}";
          max-length = 25;
          separate-outputs = true;
          offscreen-css = true;
          offscreen-css-text = "(inactive)";
          rewrite = {
            "(.*) — Mozilla Firefox" = " $1";
            "(.*) - fish" = "> [$1]";
            "(.*) - zsh" = "> [$1]";
            "(.*) - $term" = "> [$1]";
          };
        };

        idle_inhibitor = {
          tooltip = true;
          tooltip-format-activated = "Idle_inhibitor active";
          tooltip-format-deactivated = "Idle_inhibitor not active";
          format = "{icon}";
          format-icons = {
            activated = " ";
            deactivated = " ";
          };
        };

        temperature = {
          interval = 10;
          tooltip = true;
          hwmon-path = [
            "/sys/class/hwmon/hwmon1/temp1_input"
            "/sys/class/thermal/thermal_zone0/temp"
          ];
          critical-threshold = 82;
          format-critical = "{temperatureC}°C {icon}";
          format = "{temperatureC}°C {icon}";
          format-icons = [ "󰈸" ];
        };

        cpu = {
          format = "{usage}% 󰍛";
          interval = 1;
          min-length = 5;
          format-alt-click = "click";
          format-alt = "{icon0}{icon1}{icon2}{icon3} {usage:>2}% 󰍛";
          format-icons = [
            "▁"
            "▂"
            "▃"
            "▄"
            "▅"
            "▆"
            "▇"
            "█"
          ];
          on-click-right = "gnome-system-monitor";
        };

        power-profiles-daemon = {
          format = "{icon} ";
          tooltip-format = "Power profile: {profile}\nDriver: {driver}";
          tooltip = true;
          format-icons = {
            default = "";
            performance = "";
            balanced = "";
            power-saver = "";
          };
        };

        memory = {
          interval = 10;
          format = "{used:0.1f}G 󰾆";
          format-alt = "{percentage}% 󰾆";
          format-alt-click = "click";
          tooltip = true;
          tooltip-format = "{used:0.1f}GB/{total:0.1f}G";
        };

        disk = {
          interval = 30;
          path = "/";
          format = "{percentage_used}% 󰋊";
          tooltip-format = "{used} used out of {total} on {path} ({percentage_used}%)";
        };

        tray = {
          icon-size = 20;
          spacing = 4;
        };

        mpris = {
          interval = 10;
          format = "{player_icon} ";
          format-paused = "{status_icon} <i>{dynamic}</i>";
          on-click-middle = "playerctl play-pause";
          on-click = "playerctl previous";
          on-click-right = "playerctl next";
          scroll-step = 5.0;
          smooth-scrolling-threshold = 1;
          tooltip = true;
          tooltip-format = "{status_icon} {dynamic}\nLeft Click: previous\nMid Click: Pause\nRight Click: Next";
          player-icons = {
            chromium = "";
            default = "";
            firefox = "";
            kdeconnect = "";
            mopidy = "";
            mpv = "󰐹";
            spotify = "";
            vlc = "󰕼";
          };
          status-icons = {
            paused = "󰐎";
            playing = "";
            stopped = "";
          };
          max-length = 30;
        };

        "clock#2" = {
          format = "  {:%H:%M}";
          format-alt = "{:%A  |  %H:%M  |  %e %B}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        battery = {
          align = 0;
          rotate = 0;
          full-at = 100;
          design-capacity = false;
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = "󱘖 {capacity}%";
          format-alt-click = "click";
          format-full = "{icon} Full";
          format-alt = "{icon} {time}";
          format-icons = [
            "󰂎"
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          format-time = "{H}h {M}min";
          tooltip = true;
          tooltip-format = "{timeTo} {power}w";
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-bluetooth = "{icon} 󰂰 {volume}%";
          format-muted = "󰖁";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
              "󰕾"
              ""
            ];
            ignored-sinks = [
              "Easy Effects Sink"
            ];
          };
          scroll-step = 5.0;
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          on-click-right = "pavucontrol -t 3";
          on-scroll-up = "wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+";
          on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
          tooltip-format = "{icon} {desc} | {volume}%";
          smooth-scrolling-threshold = 1;
        };

        "pulseaudio#microphone" = {
          format = "{format_source}";
          format-source = " {volume}%";
          format-source-muted = "";
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          on-click-right = "pavucontrol -t 4";
          on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%+";
          on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%-";
          tooltip-format = "{source_desc} | {source_volume}%";
          scroll-step = 5;
        };

        "custom/power" = {
          format = "⏻";
          tooltip = true;
          tooltip-format = "Power";
        };

        "custom/swaync" = {
          format = "󰂚";
          tooltip = true;
          tooltip-format = "Notifications";
          on-click = "swaync-client -t -sw";
        };

        "custom/dot_update" = {
          format = "󰚰";
          tooltip = true;
          tooltip-format = "Updates";
        };
      }
    ];
  };

  xdg.configFile."waybar/style.css".text = ''
    * {
      font-family: "JetBrainsMono Nerd Font Mono", "JetBrainsMono Nerd Font", "Symbols Nerd Font Mono", monospace;
      font-size: 13px;
      font-weight: bold;
      min-height: 0;
      border: none;
      border-radius: 0;
    }

    window#waybar,
    window#waybar.empty,
    window#waybar.empty #window {
      background-color: #111111;
      color: #e7edf5;
    }

    tooltip {
      background-color: rgba(20, 20, 20, 0.96);
      color: #e7edf5;
      border: 1px solid rgba(255, 255, 255, 0.08);
      border-radius: 0;
    }

    tooltip label {
      color: #e7edf5;
      padding: 2px 4px;
    }

    .modules-left,
    .modules-center,
    .modules-right {
      background-color: transparent;
      color: #e7edf5;
      border: none;
      border-radius: 0;
      padding: 0;
    }

    #backlight,
    #backlight-slider,
    #battery,
    #bluetooth,
    #clock,
    #cpu,
    #disk,
    #idle_inhibitor,
    #keyboard-state,
    #memory,
    #mode,
    #mpris,
    #network,
    #power-profiles-daemon,
    #pulseaudio,
    #pulseaudio-slider,
    #taskbar,
    #temperature,
    #tray,
    #window,
    #wireplumber,
    #workspaces,
    #custom-backlight,
    #custom-browser,
    #custom-cava_mviz,
    #custom-cycle_wall,
    #custom-dot_update,
    #custom-file_manager,
    #custom-keybinds,
    #custom-keyboard,
    #custom-light_dark,
    #custom-lock,
    #custom-hint,
    #custom-hypridle,
    #custom-menu,
    #custom-playerctl,
    #custom-power_vertical,
    #custom-power,
    #custom-quit,
    #custom-reboot,
    #custom-settings,
    #custom-spotify,
    #custom-swaync,
    #custom-tty,
    #custom-updater,
    #custom-hyprpicker,
    #custom-weather,
    #custom-weather.clearNight,
    #custom-weather.cloudyFoggyDay,
    #custom-weather.cloudyFoggyNight,
    #custom-weather.default,
    #custom-weather.rainyDay,
    #custom-weather.rainyNight,
    #custom-weather.severe,
    #custom-weather.showyIcyDay,
    #custom-weather.snowyIcyNight,
    #custom-weather.sunnyDay {
            color: #e7edf5;
            padding: 0 10px;
            margin: 1px 0;
            border-radius: 0;
            background-color: transparent;
          }

    #backlight:hover,
    #battery:hover,
    #bluetooth:hover,
    #clock:hover,
    #cpu:hover,
    #disk:hover,
    #idle_inhibitor:hover,
    #keyboard-state:hover,
    #memory:hover,
    #mpris:hover,
    #network:hover,
    #power-profiles-daemon:hover,
    #pulseaudio:hover,
    #temperature:hover,
    #tray:hover,
    #window:hover,
    #workspaces:hover,
    #custom-browser:hover,
    #custom-dot_update:hover,
    #custom-file_manager:hover,
    #custom-keyboard:hover,
    #custom-light_dark:hover,
    #custom-lock:hover,
    #custom-menu:hover,
    #custom-power:hover,
    #custom-reboot:hover,
    #custom-settings:hover,
    #custom-swaync:hover,
    #custom-tty:hover {
            background-color: rgba(255, 255, 255, 0.05);
          }

    #clock {
            min-width: 88px;
            padding-left: 10px;
            padding-right: 10px;
            margin-right: 10px;
            color: #f1f1f1;
          }

    #window {
            color: rgba(231, 237, 245, 0.62);
            padding-left: 10px;
            padding-right: 10px;
          }

    #mpris {
            color: rgba(231, 237, 245, 0.62);
          }

    #tray {
            padding-right: 6px;
          }

    #tray>.needs-attention {
            background-color: rgba(248, 113, 113, 0.18);
            border-radius: 0;
          }

    #taskbar button,
    #workspaces button {
            color: rgba(231, 237, 245, 0.62);
            background-color: transparent;
            padding: 0 5px;
            margin: 1px 0;
            border-radius: 0;
          }

    #taskbar button:hover,
    #workspaces button:hover {
            color: #e7edf5;
            background-color: rgba(255, 255, 255, 0.05);
          }

    #taskbar button.active,
    #workspaces button.active {
            color: #ffffff;
            background-color: transparent;
            padding: 0 8px;
            margin: 0 2px;
          }

    #custom-power {
            margin-left: 10px;
            padding: 0 10px 0 15px;
          }

    #workspaces button.persistent {
            color: rgba(231, 237, 245, 0.48);
          }

    #idle_inhibitor.activated,
    #custom-hypridle.notactive {
            color: #86efac;
          }

    #pulseaudio.muted {
            color: #f87171;
          }

    #temperature.critical {
            color: #f87171;
          }

    #battery.warning {
            color: #fbbf24;
          }

          @keyframes critical-blink {
            0% {
              background-color: transparent;
              color: #f87171;
            }

            100% {
              background-color: rgba(248, 113, 113, 0.16);
              color: #ffe4e6;
            }
          }

    #battery.critical:not(.charging) {
            color: #f87171;
            animation: critical-blink 1.2s ease-in-out infinite alternate;
          }

    #battery.charging,
    #battery.plugged {
            color: #86efac;
          }

    #backlight-slider slider,
    #pulseaudio-slider slider {
            min-width: 0;
            min-height: 0;
            opacity: 0;
            background-image: none;
            border: none;
          }

    #backlight-slider trough,
    #pulseaudio-slider trough {
            min-width: 64px;
            min-height: 4px;
            background-color: rgba(255, 255, 255, 0.08);
            border-radius: 0;
          }

    #backlight-slider highlight,
    #pulseaudio-slider highlight {
            min-height: 4px;
            background-color: #d1d5db;
            border-radius: 0;
          }
  '';

}

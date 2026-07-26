{ config, ... }:

{
  xdg.configFile."waybar/scripts/focus_or_spotify.sh".source = ./scripts/focus_or_spotify.sh;
  programs.waybar = {
    enable = true;
    systemd.enable = false;

    settings = [
      {
        modules-left = [
          "custom/power"
          "sway/workspaces"
          "custom/weather"
        ];
        modules-center = [
          "clock#2"
        ];
        modules-right = [
          "tray"
          "cpu"
          "memory"
          "battery"
          "pulseaudio"
          "backlight"
          "network"
        ];

        "clock#2" = {
          format-alt = "  {:%H:%M}";
          format = "{:%A  |  %H:%M  |  %e %B}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><big>{calendar}</big></tt>";
        };

        "custom/focus" = {
          "exec" = "${config.home.homeDirectory}/.config/waybar/scripts/focus_or_spotify.sh";
          "interval" = 2;
        };
        "custom/weather" = {
          exec = "curl -s 'wttr.in/Hanoi?format=Hanoi+%t'";
          interval = 600;
          format = "{}";
          tooltip = false;
        };
        "custom/power" = {
          format = " ";
          tooltip = false;
        };

        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          format = "{icon}";
          format-icons = {
            "1" = "";
            "2" = "";
          };
        };

        tray = {
          icon-size = 20;
          spacing = 20;
        };

        network = {
          format-wifi = "  {essid}";
          format-ethernet = "  Ethernet";
          format-linked = "  Linked (No IP)";
          format-disconnected = "  Disconnected";
          tooltip = false;
        };

        cpu = {
          format = " {usage}%";
          tooltip = false;
        };

        memory = {
          format = " {used:0.1f}G";
          tooltip = false;
        };

        battery = {
          states = {
            good = 85;
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-full = "{icon} {capacity}%";
          format-plugged = " {capacity}%";
          format-charging = " {capacity}%";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
          tooltip-format = "{time}";
        };

        pulseaudio = {
          format = "{icon}  {volume}%";
          format-muted = "  {volume}%";
          format-icons = {
            default = [ "" ];
          };
          on-scroll-up = "";
          on-scroll-down = "";
        };

        backlight = {
          device = "intel_backlight";
          format = " {percent}%";
          on-scroll-up = "";
          on-scroll-down = "";
        };

        clock = {
          format = "{:%a %d/%m/%Y ~ %H:%M}";
          tooltip-format = "<span size='15000'><tt>{calendar}</tt></span>";
          on-click = "swaync-client -t -sw";
        };
      }
    ];
  };
  xdg.configFile."waybar/style.css".text = ''
    @define-color background #111111;
    @define-color foreground #eeeeee;

    @define-color gray-light #cccccc;
    @define-color gray-mid   #888888;
    @define-color gray-dark  #444444;
    * {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 13px;
        font-weight: bold;
        background-color: transparent;
        border-radius: 5px;
        min-height: 0;
    }

    #custom-weather {
        color: @blue;
        margin: 1px 0;
        padding: 0 10px;
    }

    window,
    tooltip {
        background-color: @background;
    }

    #waybar {
        background: alpha(@background, 0.6);
        border-radius: 0;
    }

    #workspaces {
        margin: 1px 0;
    }
    #backlight {
        color: @orange;
    }
        #workspaces button {
        color: @foreground;
        border: none;
        padding: 0 5px;
    }
    #workspaces button:hover {
        color: @pink;
        transition: none;
        border-bottom: 1px solid @pink;
        padding: 0 8px;
    }

    #workspaces button.active {
        color: @pink;
        border: 2px solid @pink;
        padding: 0 8px;
        margin: 0 2px;
    }

    #workspaces button.urgent {
        background-color: @red;
        padding: 0 8px;
    }

    #workspaces button.focused {
        background-color: @blue;
    }

    #custom-power,
    #tray,
    #network,
    #battery,
    #cpu,
    #memory,
    #pulseaudio,
    #clock {
        color: @foreground;
        margin: 1px 0;
        padding: 0 10px;
    }

    #custom-power:hover,
    #network:hover,
    #battery:hover,
    #pulseaudio:hover,
    #clock:hover {
        background-color: alpha(@select, 0.6);
    }

    #network {
        color: @green;
    }

    #battery {
        color: @purple;
    }

    #pulseaudio {
        color: @orange;
    }

    #clock {
        margin-right: 10px;
        color: @blue;
    }

    #custom-power {
        margin-left: 10px;
        padding: 0px 10px 0 15px;
    }
  '';

}

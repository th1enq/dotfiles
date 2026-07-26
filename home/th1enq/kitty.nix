{
  programs.kitty = {
    enable = true;
    shellIntegration.mode = "no-cursor";
  };
  xdg.configFile."kitty/kitty.conf".text = ''
    foreground #FDFDFD
    background #1D1F28
    selection_foreground #1D1F28
    selection_background #C574DD

    # cursor
    cursor #C574DD
    cursor_text_color #1D1F28

    # url
    url_color #8897F4

    # border
    active_border_color #C574DD
    inactive_border_color #414458
    bell_border_color #F2A272

    # tab bar
    active_tab_foreground #1D1F28
    active_tab_background #C574DD
    inactive_tab_foreground #FDFDFD
    inactive_tab_background #282A36
    tab_bar_background #1D1F28

    # colors (16-color palette)
    color0 #282A36
    color8 #414458

    color1 #F37F97
    color9 #FF4971

    color2 #5ADECD
    color10 #18E3C8

    color3 #F2A272
    color11 #FF8037

    color4 #8897F4
    color12 #556FFF

    color5 #C574DD
    color13 #B043D1

    color6 #79E6F3
    color14 #3FDCEE

    color7 #FDFDFD
    color15 #BEBEC1
    enable_wayland true
    font_family JetBrainsMono NF
    font_size 12

    cursor_shape block
    background_opacity 0.95
    scrollback_lines 2000
    copy_on_select yes
    mouse_hide_wait 0
    select_by_word_characters @-./_~?&=%+#a

    # cursor_trail 10
    # cursor_trail_decay 0.01 0.05
    # cursor_trail_start_threshold 0
    #
    enable_audio_bell no
    bell_on_tab 🔔 

    remember_window_size no

    window_border_width 1pt
    draw_minimal_borders yes
    window_padding_width 10
    inactive_text_alpha 0.6
    hide_window_decorations yes

    confirm_os_window_close 0

    tab_bar_style powerline
  '';
}

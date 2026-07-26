{ ... }:

{
  services.thermald.enable = true;

  # TLP handles both charge thresholds and CPU power policy. Keep
  # power-profiles-daemon off so the two daemons do not fight each other.
  # services.power-profiles-daemon.enable = false;

  services.tlp = {
    enable = true;
    settings = {
      START_CHARGE_THRESH_BAT0 = 50;
      STOP_CHARGE_THRESH_BAT0 = 100;

      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;

      PLATFORM_PROFILE_ON_AC = "balanced";
      PLATFORM_PROFILE_ON_BAT = "balanced";
      # RUNTIME_PM_ON_AC = "auto";
      # RUNTIME_PM_ON_BAT = "auto";
      #
      # WIFI_PWR_ON_AC = "off";
      # WIFI_PWR_ON_BAT = "on";
    };
  };

  # powerManagement = {
  #   enable = true;
  #   cpuFreqGovernor = "powersave";
  # };
  #
  # environment.systemPackages = with pkgs; [
  #   cpupower-gui
  #   linuxPackages.cpupower
  #   lm_sensors
  #   tlp
  # ];
}

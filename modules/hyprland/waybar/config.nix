{config, ...}: {
  home-manager.users.${config.settings.user.username}.programs.waybar.settings = {
    mainBar = {
      layer = "top";
      position = "top";
      spacing = 10;
      margin-top = 4;
      margin-left = 8;
      margin-right = 8;

      modules-left = ["hyprland/workspaces" "hyprland/window"];
      modules-center = ["clock"];
      modules-right = ["tray" "disk" "memory" "cpu" "network" "battery"];

      clock = {
        format = "{:%H:%M}";
        tooltip-format = "{:%d.%m.%Y}";
      };

      tray = {
        spacing = 3;
        icon-size = 20;
      };

      network = {
        format-ethernet = "Wired  ";
        format-wifi = "{essid} {icon}";
        format-disconnected = "";
        format-icons = ["󰤟 " "󰤢 " "󰤥 " "󰤨 "];
        tooltip-format = "{bandwidthDownBytes} 󱚶 | {bandwidthUpBytes} 󱚺 ";
      };

      cpu = {
        interval = 1;
        format = "{usage:2}%  ";
        tooltip = false;
      };

      memory = {
        interval = 1;
        format = "{percentage:2}%  ";
        tooltip = false;
      };

      disk = {
        interval = 5;
        format = "{percentage_used:2}% 󰋊";
        tooltip = false;
      };

      battery = {
        interval = 10;
        format = "{capacity:2}% {icon}";
        format-icons = [" " " " " " " " " "];
        tooltip = false;
      };

      "hyprland/workspaces" = {
        all-outputs = true;
      };

      "hyprland/window" = {
        icon = true;
        icon-size = 24;
        tooltip = false;
      };
    };
  };
}

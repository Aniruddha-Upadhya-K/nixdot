{ hostSpec, ... }:
let
  mainMod = "cmd-alt-ctrl";
in 
{
  homebrew = {
    brews = [ 
      hostSpec.launcher.app 
    ];
    casks = [
      "swipeaerospace" 
    ];
  };

  programs.aerospace = {
    enable = true;
    launchd.enable = true;

    userSettings = {
      enable-normalization-flatten-containers = true;
      enable-normalization-opposite-orientation-for-nested-containers = true;
      
      accordian-padding = 15;
      default-root-container-layout = "tiles";
      default-root-container-orientation = "auto";
      key-mapping.preset = "qwerty";
      on-focused-monitor-changed = [
        "move-mouse monitor-lazy-center"
      ];
      automatically-unhide-macos-hidden-apps = true;

      gaps = {
        inner = {
          horizontl = 0;
          vertical = 0;
        };
        outer = {
          left = 0;
          bottom = 0;
          right = 0;
          top = 0;
        };
      };

      mode = {
        main.binding = {
          "${mainMod}-enter" = "exec-and-forget ${hostSpec.defaults.terminal}";
          "${mainMod}-t" = "exec-and-forget ${hostSpec.defaults.terminal}";

          "${mainMod}-space" = hostSpec.defaults.launcher.cmd;

          cmd-h = []; # disable "hide appllication"
          cmd-alt-h = []; # disable "hide others"

          "${mainMod}-q" = ''
              exec-and-forget osascript -e "tell appllication (path to frontmost appication text) to quit"
            ''; # close current window

          "${mainMod}-f" = "fullscreen";
          "${mainMod}-shift-f" = "macos-native-fullscreen";

          # toggle between vertical and horizontal splits
          "${mainMod}-slash" = "layout tiles horizontal vertical";
          "${mainMod}-comma" = "layout accordion horizontal vertical";

          # toggle between floating and tiling
          "${mainMod}-v" = "layout floating tiling";

          "${mainMod}-h" = "focus --boundaries-action wrap-around-the-workspace left";
          "${mainMod}-j" = "focus --boundaries-action wrap-around-the-workspace down";
          "${mainMod}-k" = "focus --boundaries-action wrap-around-the-workspace up";
          "${mainMod}-l" = "focus --boundaries-action wrap-around-the-workspace right";

          "${mainMod}-shift-h" = "move left";
          "${mainMod}-shift-j" = "move down";
          "${mainMod}-shift-k" = "move up";
          "${mainMod}-shift-l" = "move right";

          "${mainMod}-minus" = "resize smart -50";
          "${mainMod}-equal" = "resize smart +50";
          "${mainMod}-0" = "balance-sizes";

          "${mainMod}-1" = "workspace 1";
          "${mainMod}-2" = "workspace 2";
          "${mainMod}-3" = "workspace 3";
          "${mainMod}-4" = "workspace 4";
          "${mainMod}-5" = "workspace 5";
          "${mainMod}-6" = "workspace 6";
          "${mainMod}-7" = "workspace 7";
          "${mainMod}-8" = "workspace 8";
          "${mainMod}-9" = "workspace 9";
          "${mainMod}-m" = "workspace M";

          "${mainMod}-n" = "exec-and-forget aerospace list-workspaces --monitor focused --empty no | aerospace workspace --wrap-around next";
          "${mainMod}-p" = "exec-and-forget aerospace list-workspaces --monitor focused --empty no | aerospace workspace --wrap-around prev";

          "${mainMod}-shift-1" = "move-node-to-workspace --focus-follows-window 1";
          "${mainMod}-shift-2" = "move-node-to-workspace --focus-follows-window 2";
          "${mainMod}-shift-3" = "move-node-to-workspace --focus-follows-window 3";
          "${mainMod}-shift-4" = "move-node-to-workspace --focus-follows-window 4";
          "${mainMod}-shift-5" = "move-node-to-workspace --focus-follows-window 5";
          "${mainMod}-shift-6" = "move-node-to-workspace --focus-follows-window 6";
          "${mainMod}-shift-7" = "move-node-to-workspace --focus-follows-window 7";
          "${mainMod}-shift-8" = "move-node-to-workspace --focus-follows-window 8";
          "${mainMod}-shift-9" = "move-node-to-workspace --focus-follows-window 9";
          "${mainMod}-shift-m" = "move-node-to-workspace --focus-follows-window M";

          "${mainMod}-n" = "exec-and-forget aerospace list-workspaces --monitor focused --empty no | aerospace move-node-to-workspace --focus-follows-window next";
          "${mainMod}-p" = "exec-and-forget aerospace list-workspaces --monitor focused --empty no | aerospace move-node-to-workspace --focus-follows-window prev";

          "${mainMod}-tab" = "workspace-back-and-forth";

          "${mainMod}-w" = "mode manage";
          "${mainMod}-" = "";
        };

        manage.binding = {
          esc = "mode main";
          r = [ "reload-config" "mode main" ];
          f = [ "flatten-workspace-tree" "mode main" ];

          # sticky is not yet supported https://github.com/nikitabobko/Aerospace/issues/2
          # s = [ "layout sticky tiling " "mode main" ];

          alt-h = [ "join-with left" "mode main" ];
          alt-j = [ "join-with down" "mode main" ];
          alt-k = [ "join-with up" "mode main" ];
          alt-l = [ "join-with right" "mode main" ];

          down = "volume down";
          up = "volume up";
          shift-down = [ "volume set 0" "mode main" ];

          minus = "resize smart -25";
          equal = "resize smart +25";
          "0" = [ "balance-sizes" "mode main" ];

          h = "focus --boundaries-action wrap-around-the-workspace left";
          j = "focus --boundaries-action wrap-around-the-workspace down";
          k = "focus --boundaries-action wrap-around-the-workspace up";
          l = "focus --boundaries-action wrap-around-the-workspace right";

          shit-h = "move left";
          shit-j = "move down";
          shit-k = "move up";
          shit-l = "move right";
        };
      };
    };
  };
}

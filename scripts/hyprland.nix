{ pkgs, ... }:

pkgs.writeShellScriptBin "hyprland-extend" ''
  while test $# -gt 0; do
    case "$1" in
      cycle) 
        shift
        if ! echo "left right up down" | grep -wq "$1"; then
          echo "$0 cycle [option]; where [option] is one of 'left' | 'right' | 'up' | 'down'"
          exit 1
        fi
        
        if ! hyprctl -j activeworkspace | ${pkgs.jq}/bin/jq $ARGS.hasfullscreen; then
          case "$1" in 
            left|down)
              hyprctl dispatch cyclenext prev
              ;;
            right|up)
              hyprctl dispatch cyclenext
              ;;
          esac
        else
          case "$1" in
            left) 
              hyprctl dispatch movefocus l
              ;;
            right) 
              hyprctl dispatch movefocus r
              ;;
            up) 
              hyprctl dispatch movefocus u
              ;;
            down) 
              hyprctl dispatch movefocus d
              ;;
          esac
        fi
        exit 0
        ;;
      *)
        echo "Avilable options are"
        echo "cycle [option]"
        echo -e "\tWhere [option] is one of the following"
        echo -e "\t'left' | 'right' | 'up' | 'down'"
        exit 0
        ;;
    esac
  done
''

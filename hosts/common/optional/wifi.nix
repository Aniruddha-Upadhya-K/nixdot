{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.networkmanagerapplet
  ];

  networking.networkmanager.dispatcherScripts = [
    {
      type = "basic";

      source =
        pkgs.writeText "disable-wireless-when-wired" # sh
          ''
            IFACE=$1
            ACTION=$2
            nmcli=${pkgs.networkmanager}/bin/nmcli

            case ''${IFACE} in
                eth*|en*)
                    case ''${ACTION} in
                        up)
                            logger "disabling wifi radio"
                            $nmcli radio wifi off
                            ;;
                        down)
                            logger "enabling wifi radio"
                            $nmcli radio wifi on
                            ;;
                    esac
                    ;;
            esac
          '';
    }
  ];

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;
  security.pam.services.greetd.enableGnomeKeyring = true;
}

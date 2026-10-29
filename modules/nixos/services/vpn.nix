# VPN module for IIIT OpenVPN
#
# First-time setup:
#   nmcli connection import type openvpn file /etc/vpn/linux.ovpn
#   nmcli connection modify "linux" vpn.user "vigneshvembar.m@students.iiit.ac.in"
#
# Usage:
#   vpn        - connect
#   vpn down   - disconnect
{
  flake.nixosModules.vpn =
    { pkgs
    , ...
    }:
    {
      networking.networkmanager.plugins = [ pkgs.networkmanager-openvpn ];
      environment.etc."vpn/linux.ovpn".source = ./vpn/linux.ovpn;
    };
}

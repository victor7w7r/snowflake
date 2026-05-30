{
  den.aspects.networking.provides.firewall.nixos.networking.firewall = {
    enable = true;
    allowPing = true;
    checkReversePath = false;
    logRefusedPackets = true;
    allowedTCPPorts = [
      22
      9090
    ];
  };
}

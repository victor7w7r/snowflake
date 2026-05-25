{
  ...
}:
{
  environment.pathsToLink = [
    "/share/applications"
    "/share/xdg-desktop-portal"
    "/share/zsh"
  ];

  services = {
    xserver.enable = true;
  };
}

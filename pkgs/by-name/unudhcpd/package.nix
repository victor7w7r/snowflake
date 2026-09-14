{ cache-stdenv, pkgs }:
cache-stdenv.mkDerivation (attrs: {
  pname = "unudhcpd";
  version = "0.2.1";

  src = pkgs.fetchFromGitLab {
    domain = "gitlab.postmarketos.org";
    owner = "postmarketOS";
    repo = "unudhcpd";
    rev = attrs.version;
    hash = "sha256-k/V3Rq8oSSPl4vaEz2EsHiRujXa/ErJoF0lq5ronGMA=";
  };

  nativeBuildInputs = with pkgs; [
    meson
    ninja
  ];

  meta = {
     description = "Basic DHCP server that only issues 1 IP address";
     homepage = "https://gitlab.postmarketos.org/postmarketOS/unudhcpd";
     license = pkgs.lib.licenses.gpl3Plus;
     maintainers = with pkgs.lib.maintainers; [ junestepp ];
     platforms = pkgs.lib.platforms.all;
     mainProgram = "unudhcpd";
   };
})

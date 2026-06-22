{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "fortune-mod-husse";
  version = "latest";

  src1 = pkgs.fetchurl {
    url = "https://aur.archlinux.org/cgit/aur.git/plain/husse-funny?h=fortune-mod-husse";
    sha256 = "sha256-H5c/Y9CHO147fla+NhIZWLlFEISekUVi7VLncohRfvM=";
  };

  src2 = pkgs.fetchurl {
    url = "https://aur.archlinux.org/cgit/aur.git/plain/husse-helping?h=fortune-mod-husse";
    sha256 = "sha256-I75m+x6VHQmcB3ov/TrVH5XT+i05lKh2MNH09lIYidc=";
  };

  src3 = pkgs.fetchurl {
    url = "https://aur.archlinux.org/cgit/aur.git/plain/husse-moderating?h=fortune-mod-husse";
    sha256 = "sha256-OdErWB6AiIzh59Z01ddWvkeekTKhoe/nqXE3P39ZpDA=";
  };

  src4 = pkgs.fetchurl {
    url = "https://aur.archlinux.org/cgit/aur.git/plain/husse-self?h=fortune-mod-husse";
    sha256 = "sha256-2Irw7bRvq+HqSG32ENRtWiv2ZkIPcSjTqHpeJkkQzYs=";
  };

  dontUnpack = true;

  nativeBuildInputs = with pkgs; [ fortune ];

  installPhase = ''
    cp $src1 husse-funny
    cp $src2 husse-helping
    cp $src3 husse-moderating
    cp $src4 husse-self

    strfile husse-funny
    strfile husse-helping
    strfile husse-moderating
    strfile husse-self

    install -dm755 -- "$out/share/games/fortunes"
    install -m644 -- husse-funny husse-funny.dat "$out/share/games/fortunes"
    install -m644 -- husse-helping husse-helping.dat "$out/share/games/fortunes"
    install -m644 -- husse-moderating husse-moderating.dat "$out/share/games/fortunes"
    install -m644 -- husse-self husse-self.dat "$out/share/games/fortunes"
  '';
})

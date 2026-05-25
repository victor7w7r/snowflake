{
  host,
  pkgs,
  ...
}:
{
  environment.systemPackages =
    with pkgs;
    [
      age
      atool
      brightnessctl
      brush
      cheat
      choose
      cmd-wrapped
      cod

      emptty
      evemu

      inotify-tools

      firejail
      hexyl
      libinput
      iio-sensor-proxy
      jump
      libiio
      luksmeta
      keyd
      mdadm
      modprobed-db
      rsyncy
      efibootmgr

      phraze
      progress
      pv
      rage
      seadrive-fuse
      seafile-shared
      #sampler
      sd
      sig
      tre-command

      tmux
      veracrypt
      vtm
      wol
      wtfutil

      #(pkgs.callPackage ./custom/hf.nix { })
      #(pkgs.callPackage ./custom/loop.nix { })
      #(pkgs.callPackage ./custom/procmux.nix { })
      #(pkgs.callPackage ./custom/progressline.nix { })
      (pkgs.callPackage ./custom/texoxide.nix { })
    ]
    ++ [

    ]
    ++ (if host != "v7w7r-rc71l" && system != "aarch64-linux" then [ intel-undervolt ] else [ ])
    ++ (if system != "aarch64-linux" then [ boxxy ] else [ ])
    ++ [
      alejandra
      cached-nix-shell
      comma
      deadnix
      lorri
      fh
      manix
      namaka
      niv
      #inputs.nix-alien.packages.${system}.nix-alien
      nix-diff
      nix-du
      nix-health
      nix-init # !!!!!
      nix-melt
      nix-output-monitor
      nixpkgs-review
      nix-search-cli
      nix-tree
      nix-update
      nixfmt
      nvd
      optnix
      statix
    ];
}

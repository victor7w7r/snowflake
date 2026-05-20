{
  nixConfig = {
    extra-sandbox-paths = [
      "/nix/var/cache/ccache"
      "/nix/var/cache/sccache"
    ];
    extra-substituters = [
      "https://cache.nixos.org/"
      "https://nix-gaming.cachix.org"
      "https://nix-community.cachix.org"
      "https://cache.garnix.io"
      "https://cache.saumon.network/proxmox-nixos"
    ];
    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "proxmox-nixos:D9RYSWpQQC/msZUWphOY2I5RLH5Dd6yQcaHIuug7dWM="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
    ];
  };

  outputs =
    {
      nixpkgs,
      self,
      nix-cachyos-kernel,
      nur,
      disko,
      proxmox-nixos,
      impermanence,
      home-manager,
      nix-flatpak,
      nixvim,
      agenix,
      nixos-hardware,
      ...
    }@inputs:
    let
      username = "victor7w7r";
      system = "x86_64-linux";
      systemarm = "aarch64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          nix-cachyos-kernel.overlays.pinned
          (import "${inputs.mobile-nixos}/overlay/overlay.nix")
        ];
      };
      armPkgs = import nixpkgs {
        system = systemarm;
        overlays = [
          (import "${inputs.mobile-nixos}/overlay/overlay.nix")
        ];
      };

      home = (pkgs.callPackage ./modules/home { inherit self inputs username; }).home-manager;
      helpers = pkgs.callPackage "${inputs.nix-cachyos-kernel.outPath}/helpers.nix" { };
    in
    {
      packages = {
        "${systemarm}" = {
          sunxiconfig =
            (armPkgs.callPackage ./kernel/sunxi {
              kernelData = nixpkgs.lib.trivial.importJSON ./kernel.json;
            }).kernel.kconfigToNix;

          qcomconfig =
            (armPkgs.callPackage ./kernel/sdm845 {
              kernelData = nixpkgs.lib.trivial.importJSON ./kernel.json;
            }).build.kconfigToNix;

          qcomconfigflat =
            (armPkgs.callPackage ./kernel/sdm845 {
              kernelData = nixpkgs.lib.trivial.importJSON ./kernel.json;
            }).build.kconfigFile;
        };
        "${system}" = {
          rogallyconfig =
            (pkgs.callPackage ./kernel {
              host = "v7w7r-rc71l";
              inherit helpers inputs;
              kernelData = nixpkgs.lib.trivial.importJSON ./kernel.json;
            }).kernel.kconfigToNix;

          serverconfig =
            (pkgs.callPackage ./kernel {
              host = "v7w7r-youyeetoox1";
              inherit helpers inputs;
              kernelData = nixpkgs.lib.trivial.importJSON ./kernel.json;
            }).kernel.kconfigToNix;

          macminiconfig =
            (pkgs.callPackage ./kernel {
              host = "v7w7r-macmini81";
              inherit helpers inputs;
              kernelData = nixpkgs.lib.trivial.importJSON ./kernel.json;
            }).kernel.kconfigToNix;

          qcomconfig =
            (pkgs.callPackage ./kernel/sdm845 {
              kernelData = nixpkgs.lib.trivial.importJSON ./kernel.json;
            }).build.kconfigToNix;

          qcomconfigflat =
            (pkgs.callPackage ./kernel/sdm845 {
              kernelData = nixpkgs.lib.trivial.importJSON ./kernel.json;
            }).build.kconfigFile;

          sunxiconfig =
            (pkgs.callPackage ./kernel/sunxi {
              kernelData = nixpkgs.lib.trivial.importJSON ./kernel.json;
            }).kernel.kconfigToNix;
        };
      };

      homeConfigurations."${username}" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        inherit (home)
          extraSpecialArgs
          ;
      };

      nixosConfigurations = {
        #nix build -L ".#nixosConfigurations.opizero2w.config.system.build.toplevel"
        #nix build -L ".#nixosConfigurations.opizero2w.config.system.build.sdImage"
        #nix build -L ".#nixosConfigurations.opizero2w.config.system.build.tarball"
        #nix build -L ".#nixosConfigurations.opizero2w.config.system.build.bootFiles"
        #dd if=u-boot-sunxi-with-spl.bin of=/dev/sde bs=1024 seek=8 conv=notrunc
        #mount /dev/sde1 /mnt && rm -rf /mnt/* && tar --zstd -xvf boot.tar.zst -C /mnt/ --no-same-owner && umount /dev/sde1 && udisksctl power-off -b /dev/sde
        #mount -o noatime,nodiratime,lazytime,logbufs=8,logbsize=256k /dev/sde1 /mnt && rm -rf /mnt/* && tar --zstd -xvf store.tar.zst -C /mnt/ && sync && umount /dev/sde1 && udisksctl power-off -b /dev/sde
        opizero2w = nixpkgs.lib.nixosSystem {
          system = systemarm;
          modules = [
            (
              { ... }:
              {
                nixpkgs.hostPlatform = "aarch64-linux";
                nixpkgs.config.allowUnsupportedSystem = true;
                nixpkgs.overlays = [ inputs.emacs-overlay.overlay ];
              }
            )
            (import ./configuration.nix)
            (import ./pkgs)
            (import ./hosts/opizero2w.nix)
            impermanence.nixosModules.impermanence
            home-manager.nixosModules.home-manager
            disko.nixosModules.disko
            nur.modules.nixos.default
            nixvim.nixosModules.nixvim
            agenix.nixosModules.default
            (import ./modules/core)
            (import ./modules/home)
          ];
          specialArgs = {
            host = "v7w7r-opizero2w";
            system = systemarm;
            kernelData = nixpkgs.lib.trivial.importJSON ./kernel.json;
            inherit
              self
              inputs
              username
              ;
          };
        };

        #nix build -L ".#nixosConfigurations.fajita.config.system.build.toplevel"
        #nix build -L ".#nixosConfigurations.fajita.config.system.build.tarball"
        #nix build -L ".#nixosConfigurations.fajita.config.mobile.outputs.android.android-bootimg"
        #mount /dev/sde17 /mnt && rm -rf /mnt/* && tar --zstd -xvf efi.tar.zst -C /mnt/ --no-same-owner && umount /dev/sde17
        #export OPTS="noatime,compress_chksum,compress_algorithm=zstd,age_extent_cache,compress_extension=so,inline_xattr,inline_data,inline_dentry,errors=remount-ro,compress_extension=bin,atgc,flush_merge,discard,checkpoint_merge,gc_merge"
        #mount -o $OPTS /dev/sde18 /mnt && rm -rf /mnt/* && tar --zstd -xvf store.tar.zst -C /mnt/
        fajita = nixpkgs.lib.nixosSystem {
          system = systemarm;
          modules = [
            (
              { ... }:
              {
                nixpkgs.hostPlatform = "aarch64-linux";
                nixpkgs.config.allowUnsupportedSystem = true;
                nixpkgs.overlays = [
                  (import "${inputs.mobile-nixos}/overlay/overlay.nix")
                  inputs.emacs-overlay.overlay
                ];
              }
            )
            (import ./configuration.nix)
            (import ./pkgs)
            (import ./hosts/fajita.nix)
            impermanence.nixosModules.impermanence
            home-manager.nixosModules.home-manager
            nur.modules.nixos.default
            nixvim.nixosModules.nixvim
            agenix.nixosModules.default
            (import ./modules/core)
            (import ./modules/home)
          ]
          ++ (import "${inputs.mobile-nixos}/modules/module-list.nix");
          specialArgs = {
            host = "v7w7r-fajita";
            system = systemarm;
            kernelData = nixpkgs.lib.trivial.importJSON ./kernel.json;
            inherit
              self
              inputs
              username
              ;
          };
        };

        macmini = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            (
              { ... }:
              {
                nixpkgs.overlays = [
                  nix-cachyos-kernel.overlays.pinned
                  inputs.emacs-overlay.overlay
                ];
              }
            )
            (import ./configuration.nix)
            (import ./pkgs)
            nixos-hardware.nixosModules.apple-t2
            nur.modules.nixos.default
            nix-flatpak.nixosModules.nix-flatpak
            impermanence.nixosModules.impermanence
            home-manager.nixosModules.home-manager
            nixvim.nixosModules.nixvim
            (import ./hosts/macmini.nix)
            (import ./modules/core)
            (import ./modules/home)
            agenix.nixosModules.default
          ];
          specialArgs = {
            host = "v7w7r-macmini81";
            kernelData = nixpkgs.lib.trivial.importJSON ./kernel.json;
            inherit
              self
              inputs
              username
              system
              ;
          };
        };

        rogally = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            (
              { ... }:
              {
                nixpkgs.overlays = [
                  nix-cachyos-kernel.overlays.pinned
                  inputs.emacs-overlay.overlay
                ];
              }
            )
            (import ./configuration.nix)
            (import ./pkgs)
            nixos-hardware.nixosModules.asus-ally-rc71l
            nix-flatpak.nixosModules.nix-flatpak
            home-manager.nixosModules.home-manager
            nixvim.nixosModules.nixvim
            (import ./hosts/rogally.nix)
            (import ./modules/core)
            (import ./modules/home)
            nur.modules.nixos.default
            impermanence.nixosModules.impermanence
            agenix.nixosModules.default
          ];
          specialArgs = {
            host = "v7w7r-rc71l";
            kernelData = nixpkgs.lib.trivial.importJSON ./kernel.json;
            inherit
              self
              nix-cachyos-kernel
              inputs
              username
              system
              ;
          };
        };

        server = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            (
              { ... }:
              {
                nixpkgs.overlays = [
                  nix-cachyos-kernel.overlays.default
                  inputs.emacs-overlay.overlay
                  proxmox-nixos.overlays.${system}
                ];
              }
            )
            (import ./configuration.nix)
            (import ./pkgs)
            nixos-hardware.nixosModules.common-pc-ssd
            proxmox-nixos.nixosModules.proxmox-ve
            nixos-hardware.nixosModules.common-cpu-intel
            home-manager.nixosModules.home-manager
            nix-flatpak.nixosModules.nix-flatpak
            impermanence.nixosModules.impermanence
            nixvim.nixosModules.nixvim
            (import ./hosts/server.nix)
            (import ./modules/core)
            (import ./modules/home)
            nur.modules.nixos.default
            agenix.nixosModules.default
          ];
          specialArgs = {
            host = "v7w7r-youyeetoox1";
            kernelData = nixpkgs.lib.trivial.importJSON ./kernel.json;
            inherit
              self
              inputs
              username
              system
              ;
          };
        };

        vm = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            (
              { ... }:
              {
                nixpkgs.overlays = [
                  nix-cachyos-kernel.overlays.pinned
                  inputs.emacs-overlay.overlay
                ];
              }
            )
            (import ./configuration.nix)
            (import ./pkgs)
            nixos-hardware.nixosModules.common-pc-ssd
            nixos-hardware.nixosModules.common-cpu-intel
            impermanence.nixosModules.impermanence
            home-manager.nixosModules.home-manager
            nixvim.nixosModules.nixvim
            nix-flatpak.nixosModules.nix-flatpak
            (import ./hosts/vm.nix)
            (import ./modules/core)
            (import ./modules/home)
            nur.modules.nixos.default
            agenix.nixosModules.default
          ];
          specialArgs = {
            host = "v7w7r-nixvm";
            kernelData = nixpkgs.lib.trivial.importJSON ./kernel.json;
            inherit
              self
              inputs
              username
              system
              ;
          };
        };
      };
    };
}

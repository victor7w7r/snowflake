
  /*
    overlays = [
     nix-cachyos-kernel.overlays.pinned
     (import "${inputs.mobile-nixos}/overlay/overlay.nix")
     ];

     helpers = pkgs.callPackage "${inputs.nix-cachyos-kernel.outPath}/helpers.nix" { };

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
  */

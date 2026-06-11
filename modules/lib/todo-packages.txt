  /*
     bootFiles = ''
       mkdir -p boot
       ${config.boot.loader.generic-extlinux-compatible.populateCmd} \
         -c ${config.system.build.toplevel} -d boot
       tar -cv -C . boot | zstd -T$NIX_BUILD_CORES > $out/boot.tar.zst
     '';
     system.build.bootFiles =
       pkgs.runCommand "boot-files" { nativeBuildInputs = with pkgs; [ zstd ]; }
         ''
           mkdir -p $out
           ${bootFiles}
         '';

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

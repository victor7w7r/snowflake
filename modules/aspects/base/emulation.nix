{ lib, ... }:
{
  den.aspects.base.emulation.nixos =
    {
      isArm,
      isPersistent,
      isX86,
      pkgs,
      ...
    }:
    {
      boot.binfmt = lib.optionalAttrs isPersistent {
        preferStaticEmulators = true;
        emulatedSystems = [
          "x86_64-windows"
          "i686-windows"
          "wasm64-wasi"
          "wasm32-wasi"
        ]
        ++ lib.optionals isX86 [ "aarch64-linux" ]
        ++ lib.optionals isArm [ "x86_64-linux" ];
        registrations = {
          aarch64-linux = lib.optionalAttrs isX86 {
            interpreter = "${pkgs.pkgsStatic.qemu-user}/bin/qemu-aarch64";
            matchCredentials = true;
            wrapInterpreterInShell = false;
            preserveArgvZero = false;
            fixBinary = true;
          };

          FEX-x86_64 = lib.optionalAttrs isArm {
            interpreter = "${pkgs.fex or "/usr/bin/FEXInterpreter"}/bin/FEXInterpreter";
            recognitionType = "magic";
            magicOrExtension = ''\x7fELF\x02\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x3e\x00'';
            mask = ''\xff\xff\xff\xff\xff\xfe\xfe\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff'';
            preserveArgvZero = true;
            fixBinary = true;
            wrapInterpreterInShell = false;
          };

          FEX-i386 = lib.optionalAttrs isArm {
            interpreter = "${pkgs.fex or "/usr/bin/FEXInterpreter"}/bin/FEXInterpreter";
            recognitionType = "magic";
            magicOrExtension = ''\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x03\x00'';
            mask = ''\xff\xff\xff\xff\xff\xfe\xfe\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff'';
            preserveArgvZero = true;
            fixBinary = true;
            wrapInterpreterInShell = false;
          };

          javascript-bun = {
            recognitionType = "extension";
            magicOrExtension = "js";
            interpreter = pkgs.writeShellScript "js-bun-wrapper" ''${pkgs.bun}/bin/bun "$@"'';
          };

          jar = {
            recognitionType = "extension";
            magicOrExtension = "jar";
            interpreter = pkgs.writeScript "binfmt-jar" ''
              #!/bin/sh
              exec ${pkgs.openjdk}/bin/java -jar "$@"
            '';
          };

          windows = lib.optionalAttrs isX86 {
            interpreter = "${pkgs.wine}/bin/wine";
            offset = 0;
            magicOrExtension = "MZ";
          };

          appimage = {
            wrapInterpreterInShell = false;
            interpreter = "${pkgs.appimage-run}/bin/appimage-run";
            recognitionType = "magic";
            offset = 0;
            mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
            magicOrExtension = ''\x7fELF....AI\x02'';
          };
        };
      };
    };
}

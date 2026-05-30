{ lib, ... }:
{
  den.aspects.hosts =
    { config, ... }:
    rec {
      imports = with lib; [
        {
          options = {
            generic = mkOption { type = with types; str; };
            handheld = mkOption { type = with types; str; };
            main = mkOption { type = with types; str; };
            main-mac = mkOption { type = with types; str; };
            live = mkOption { type = with types; str; };
            phone = mkOption { type = with types; str; };
            pizero = mkOption { type = with types; str; };
            server = mkOption { type = with types; str; };
            superlab = mkOption { type = with types; str; };
            efi = mkOption { type = with types; listOf str; };
            tpm = mkOption { type = with types; listOf str; };
            graphicarm = mkOption { type = with types; listOf str; };
            x86 = mkOption { type = with types; listOf str; };
            arm = mkOption { type = with types; listOf str; };
            graphic = mkOption { type = with types; listOf str; };
            desktop = mkOption { type = with types; listOf str; };
            softwaregui = mkOption { type = with types; listOf str; };
            peripheralgui = mkOption { type = with types; listOf str; };
          };
        }
      ];

      generic = "generic";
      handheld = "handheld";
      main = "main";
      main-mac = "main-mac";
      live = "live";
      phone = "phone";
      pizero = "pizero";
      server = "server";
      superlab = "superlab";

      tpm = [
        server
        handheld
      ];

      efi = [
        main
        generic
      ];

      graphicarm = [
        phone
        superlab
      ];

      x86 = tpm ++ efi;
      arm = graphicarm ++ [ pizero ];

      graphic = x86 ++ graphicarm;

      #(NOT phone)
      desktop = x86 ++ [ superlab ];

      #(NOT server)
      softwaregui = efi ++ graphicarm ++ [ handheld ];

      #(NOT phone AND server)
      peripheralgui = efi ++ [
        handheld
        superlab
      ];
    };
}

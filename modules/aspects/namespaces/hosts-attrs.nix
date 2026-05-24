let
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

in
{
  hosts-attrs = {
    inherit
      generic
      handheld
      main
      main-mac
      live
      phone
      pizero
      server
      superlab

      tpm
      efi
      graphicarm
      x86
      arm
      graphic
      desktop
      softwaregui
      peripheralgui
      ;
  };
}

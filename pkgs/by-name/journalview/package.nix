{ fetchFromGitHub, rustPlatform }:
rustPlatform.buildRustPackage (attrs: {
  pname = "journalview";
  version = "main";

  src = fetchFromGitHub {
    owner = "codervijo";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-XHR35n5MJ/wmeIj3YbC5SzOGbkHf+oAHezJXTp2R0+0=";
  };

  cargoHash = "sha256-OxOfadX+z6KRmnj8e/QVvdSafjlelb2AyIIEpKONChg=";
})

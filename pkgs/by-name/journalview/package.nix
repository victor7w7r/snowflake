{ fetchFromGitHub, rustPlatform }:
rustPlatform.buildRustPackage (attrs: {
  pname = "journalview";
  version = "latest";

  src = fetchFromGitHub {
    owner = "codervijo";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-XHR35n5MJ/AAAIj3YbC5SzOGbkHf+oAHezJXTp2R0+0=";
  };

  cargoHash = "sha256-OxOfadX+z6KAAAj8e/QVvdSafjlelb2AyIIEpKONChg=
";
})

{
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage rec {
  pname = "jwt-ui";
  version = "latest";

  src = fetchFromGitHub {
    owner = "jwt-rs";
    repo = pname;
    rev = version;
    sha256 = "sha256-XHR35n5MJ/AAAIj3YbC5SzOGbkHf+oAHezJXTp2R0+0=";
  };

  cargoHash = "sha256-OxOfadX+z6KAAAj8e/QVvdSafjlelb2AyIIEpKONChg=
";
}

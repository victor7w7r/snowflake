{ fetchFromGitHub, rustPlatform }:
rustPlatform.buildRustPackage (attrs: {
  pname = "ssh-list";
  version = "main";

  src = fetchFromGitHub {
    owner = "akinoiro";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-AHfyWpcrkP/6pXP7MIpQ8Ze6IA8RuWe19OlkniWCnAc=";
  };

  cargoHash = "sha256-J4pBaZBqIbUYuMdwy6F5KNCfAZUWRvozvsPP2zl7aDc=";
})

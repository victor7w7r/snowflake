{ fetchFromGitHub, rustPlatform }:
rustPlatform.buildRustPackage (attrs: {
  pname = "socktop";
  version = "main";

  src = fetchFromGitHub {
    owner = "jasonwitty";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-AHfyWpcrkP/6pXPAAIpQ8Ze6IA8RuWe19OlkniWCnAc=";
  };

  cargoHash = "sha256-J4pBaZBqIbUYuAAwy6F5KNCfAZUWRvozvsPP2zl7aDc=";
})

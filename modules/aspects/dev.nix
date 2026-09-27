{
  den.aspects.dev =
    { user, ... }:
    {
      nixos =
        {
          config,
          lib,
          pkgs,
          ...
        }:
        {
          environment = {
            systemPackages = with pkgs; [
              mise
              tracexec
              #elia-chat
              #dblab
              #gobang
            ];
            persistence."/nix/persist".users."${user.name}".directories = lib.mkAfter [
              ".cache/mise"
              ".cargo"
              ".local/share/mise"
              ".npm"
              ".rustup"
            ];
          };

          nixpkgs.overlays = [
            (_: prev: {
              ccacheWrapper = prev.ccacheWrapper.override {
                extraConfig = ''
                  export CCACHE_COMPRESS=1
                  export CCACHE_DIR="${config.programs.ccache.cacheDir}"
                  export CCACHE_UMASK="007"
                  export CCACHE_SLOPPINESS=random_seed
                  export CCACHE_PREFIX="${prev.strace}/bin/strace -e trace=file,process -o /tmp/ccache_strace.log"
                '';
              };
            })
          ];
          systemd.tmpfiles.rules = [
            "d ${config.programs.ccache.cacheDir}                        770 root    nixbld  - -"
            "d /var/cache/sccache                        770 root    nixbld  - -"
            "d /var/cache/gocache                        770 root    nixbld  - -"
          ];
          nix.settings.extra-sandbox-paths = [
            config.programs.ccache.cacheDir
            "/var/cache/sccache"
            "/var/cache/gocache"
          ];
          programs.ccache.enable = true;
        };

      os =
        { pkgs, self', ... }:
        {
          environment.systemPackages =
            with pkgs;
            with self'.packages;
            [
              atac
              dos2unix
              curlie
              httpie
              fw
              jless
              just
              jwtui
              ktlint
              kyun
              loc
              mynav
              posting
              rainfrog
              shellcheck
              ugm
              xh
            ];
          programs.direnv = {
            enable = false;
            enableZshIntegration = true;
            nix-direnv.enable = true;
          };
        };

      provides.to-users.homeManager.programs = {
        #aichat.enable = true;
        #aider-chat.enable = true;
        #meli.enable = true; BUILD
        #visidata.enable = true;
        gitui.enable = true;
        jq.enable = true;
        lazysql.enable = true;
        mods.enable = true;
        pyenv = {
          enable = true;
          enableZshIntegration = true;
          enableBashIntegration = true;
        };
        mise = {
          enable = true;
          enableZshIntegration = true;
          enableBashIntegration = true;
          globalConfig = {
            settings = {
              trusted_config_paths = [ "~/repositories" ];
              node.compile = false;
              npm.bun = true;
            };
          };
        };
      };
    };
}

{
  den.default.os =
    {
      lib,
      pkgs,
      self',
      ...
    }:
    {
      programs.nixvim = {
        extraPackages = with pkgs; [
          glab
          luajitPackages.tree-sitter-cli
          self'.packages.dbee
          sqlite
        ];

        extraPlugins = [ pkgs.vimPlugins.vim-dotenv ];

        lsp.servers = {
          astro.enable = true;
          bashls.enable = true;
          cssls.enable = true;
          dartls.enable = true;
          docker_compose_language_service.enable = true;
          dockerls.enable = true;
          emmet_ls.enable = true;
          html.enable = true;
          gitlab_ci_ls.enable = true;
          jsonls.enable = true;
          kotlin_language_server.enable = true;
          marksman.enable = true;
          oxfmt.enable = true;
          oxlint.enable = true;
          nixd = {
            enable = true;
            package = pkgs.nixd;
            config = {
              cmd = [ (lib.getExe pkgs.nixd) ];
              filetypes = [ "nix" ];
              root_markers = [ ".git" ];
            };
          };
          postgres_lsp.enable = true;
          pylsp.enable = true;
          rust_analyzer = {
            enable = true;
            config.settings = {
              cargo = {
                loadOutDirsFromCheck = true;
                features = "all";
                buildScripts.enable = false;
              };

              procMacro.enable = true;

              diagnostics = {
                enable = true;
                styleLints.enable = true;
              };

              checkOnSave = true;
              check.command = "clippy";

              files.excludeDirs = [
                ".direnv"
                "target"
                ".git"
              ];
            };
          };
          statix.enable = true;
          stylelint_lsp.enable = true;
          svelte.enable = true;
          ts_ls.enable = true;
          #vue_ls.enable = true;
          yamlls.enable = true;
        };

        plugins = {
          bullets = {
            enable = true;
            lazyLoad.settings.settings.ft = [
              "markdown"
              "txt"
              "gitcommit"
            ];
          };

          crates = {
            enable = true;
            lazyLoad.settings.ft = "BufRead Cargo.toml";
          };

          lspconfig.enable = true;

          markdown-preview = {
            enable = true;
            lazyLoad.settings.ft = "markdown";
            settings = {
              auto_close = 0;
              auto_start = 0;
              browser = "zen";
              echo_preview_url = 0;
              open_to_the_world = 0;
              refresh_slow = 0;
              theme = "dark";
              preview_options = {
                disable_sync_scroll = 0;
                sync_scroll_type = "relative";
              };
            };
          };

          package-info = {
            enable = true;
            lazyLoad.settings.event = "BufRead package.json";
            settings = {
              hide_up_to_date = true;
              hide_unstable_versions = true;
              package_manager = "bun";
            };
          };

          treesitter = {
            enable = true;
            lazyLoad.settings.event = [
              "BufReadPost"
              "BufNewFile"
            ];
            nixvimInjections = true;
            nixGrammars = true;
            settings = {
              auto_install = true;
              highlight.enable = true;
              indent.enable = true;
              folding.enable = true;
            };
            grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
              astro
              bash
              css
              dart
              diff
              dockerfile
              git_config
              git_rebase
              gitattributes
              gitcommit
              gitignore
              html
              ini
              javascript
              json
              kotlin
              markdown
              nix
              python
              query
              regex
              rust
              sql
              ssh_config
              svelte
              tsx
              typescript
              vue
              xml
              yaml
              zsh
            ];
          };

          conform-nvim = {
            enable = true;
            autoInstall.enable = true;
            lazyLoad.settings.event = [
              "BufReadPost"
              "BufNewFile"
            ];
            settings = {
              notify_on_error = true;
              notify_no_formatters = true;
              log_level = "info";
              default_format_opts.lsp_format = "fallback";

              format_on_save.__raw = ''
                function(bufnr)
                  if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return
                  end
                  return { timeout_ms = 3000, lsp_fallback = true }
                end
              '';

              formatters_by_ft = {
                "_" = [
                  "trim_newlines"
                  "trim_whitespace"
                ];
                astro = [ "biome" ];
                bash = [ "shfmt" ];
                css = [ "oxfmt" ];
                dockerfile = [ "dockerfmt" ];
                dart = [ "dart_format" ];
                html = [ "oxfmt" ];
                javascript = [ "oxfmt" ];
                json = [ "oxfmt" ];
                kotlin = [ "ktlint" ];
                nix = [ "nixfmt" ];
                python = [
                  "isort"
                  "black"
                ];
                rust = [ "rustfmt" ];
                sh = [ "shfmt" ];
                sql = [ "pg_format" ];
                svelte = [ "oxfmt" ];
                typescript = [ "oxfmt" ];
                typescriptreact = [ "oxfmt" ];
                vue = [ "oxfmt" ];
                yaml = [ "yamlfmt" ];
              };

              formatters = {
                biome.command = lib.getExe pkgs.biome;
                black.command = lib.getExe pkgs.black;
                dockerfmt.command = lib.getExe pkgs.dockerfmt;
                isort.command = lib.getExe pkgs.isort;
                ktlint.command = lib.getExe pkgs.ktlint;
                nixfmt.command = lib.getExe pkgs.nixfmt;
                pg_format.command = lib.getExe pkgs.pgformatter;
                rustfmt.command = lib.getExe pkgs.rustfmt;
                shfmt.command = lib.getExe pkgs.shfmt;
                yamlfmt = {
                  command = lib.getExe pkgs.yamlfmt;
                  args = [ "-" ];
                };
                oxfmt.command.__raw = ''
                  function(self, ctx)
                    local root = require("conform.util").root_file({ "package.json", ".git" })(self, ctx)
                    local local_cmd = root and root .. "/node_modules/.bin/oxfmt"
                    if local_cmd and vim.fn.executable(local_cmd) == 1 then
                      return local_cmd
                    end
                    return "oxfmt"
                  end
                '';
              };
            };
          };

          lint = {
            enable = true;
            autoLoad = true;
            lintersByFt = {
              astro = [ "oxlint" ];
              bash = [ "shellcheck" ];
              css = [ "oxlint" ];
              dockerfile = [ "hadolint" ];
              gitcommit = [ "gitlint" ];
              javascript = [ "oxlint" ];
              json = [ "oxlint" ];
              kotlin = [ "detekt" ];
              nix = [ "deadnix" ];
              python = [ "pylint" ];
              sh = [ "shellcheck" ];
              sqlfluff = [ "sqlfluff" ];
              svelte = [ "oxlint" ];
              text = [ "vale" ];
              typescript = [ "oxlint" ];
              typescriptreact = [ "oxlint" ];
              vue = [ "oxlint" ];
              yaml = [ "yamllint" ];
            };
            linters = {
              deadnix.cmd = lib.getExe pkgs.deadnix;
              detekt.cmd = lib.getExe pkgs.detekt;
              gitlint.cmd = lib.getExe pkgs.gitlint;
              hadolint.cmd = lib.getExe pkgs.hadolint;
              pylint.cmd = lib.getExe pkgs.pylint;
              vale.cmd = lib.getExe pkgs.vale;
              shellcheck.cmd = lib.getExe pkgs.shellcheck;
              sqlfluff.cmd = lib.getExe pkgs.sqlfluff;
              yamllint.cmd = lib.getExe pkgs.yamllint;
            };
          };
        };

        extraConfigLuaPost = ''
          require("lint").linters.oxlint.cmd = function()
            local root = vim.fs.root(0, { "oxlint.config.ts" })
            local bin = root and (root .. "/node_modules/.bin/oxlint")
            if bin and vim.uv.fs_stat(bin) then
              return bin
            end
            return "true"
          end
        '';
      };
    };
}

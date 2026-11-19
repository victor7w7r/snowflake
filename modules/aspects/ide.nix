{
  den.aspects.ide =
    { user, ... }:
    {
      nixos =
        {
          lib,
          pkgs,
          options,
          ...
        }:
        {
          environment = {
            systemPackages = with pkgs; [
              binaryen
              binutils
              gcc
              upx
            ];

            etc."swift/x86_64-unknown-linux-gnu-clang.cfg".text =
              let
                glibcLib = lib.getLib pkgs.glibc;
                gccLib = lib.getLib pkgs.gcc.cc;
                gccDir = "${pkgs.gcc.cc}/lib/gcc/${pkgs.stdenv.hostPlatform.config}/${pkgs.gcc.cc.version}";
              in
              ''
                -Wno-unused-command-line-argument
                -B${glibcLib}/lib
                -B${gccDir}
                -L${glibcLib}/lib
                -L${gccDir}
                -L${gccLib}/lib
              '';

            # TC="$(mise where swift)/usr/bin"; ln -sf /etc/swift/x86_64-unknown-linux-gnu-clang.cfg "$TC/x86_64-unknown-linux-gnu-clang.cfg"

            sessionVariables =
              (lib.concatStringsSep ":" [
                "${lib.getLib pkgs.glibc}/lib"
                "${pkgs.gcc.cc}/lib/gcc/${pkgs.stdenv.hostPlatform.config}/${pkgs.gcc.cc.version}"
                "${lib.getLib pkgs.gcc.cc}/lib"
              ])
              |> (linkPaths: {
                COMPILER_PATH = linkPaths + ":${pkgs.binutils}/bin";
                LIBRARY_PATH = linkPaths;
                C_INCLUDE_PATH = "${pkgs.glibc.dev}/include";
              });

            persistence."/nix/persist".users."${user.name}".directories = lib.mkAfter [
              ".cache/JetBrains"
              ".config/bruno"
              ".config/JetBrains"
              ".java"
              ".jb_run"
              ".swiftpm"
              ".local/share/JetBrains"
            ];
          };

          systemd.tmpfiles.rules = [ "L+ /usr/include - - - - ${pkgs.glibc.dev}/include" ];

          programs.nix-ld.libraries =
            options.programs.nix-ld.libraries.default
            ++ (with pkgs; [
              curl
              libedit
              libxml2
              libxml2_13
              ncurses
              sqlite
              stdenv.cc.cc
              stdenv.cc.cc.lib
              util-linux
              zlib
            ]);
        };

      provides.to-users.homeManager =
        { pkgs, ... }:
        {
          home = {
            packages = with pkgs; [
              bruno
              jetbrains.idea
            ];

            file.".ideavimrc".text = ''
              nmap <space> <nop>
              let mapleader = " "

              set highlightedyank
              set multiple-cursors
              set surround
              set textobj-indent
              set which-key
              set yankring

              set autoindent
              set clipboard^=ideaput
              set clipboard+=unnamedplus
              set history=1000
              set hlsearch
              set ideajoin
              set ideamarks
              set ignorecase
              set incsearch
              set notimeout
              set timeoutlen=5000
              set number relativenumber
              set scrolloff=5
              set showmode
              set sidescrolloff=5
              set smartcase
              set visualbell

              nnoremap U :action $Redo<cr>

              call whichKey("<leader>qq", "Quit")
              map <leader>qq <Action>(Quit)

              call whichKey("<leader>fd", "Find content")
              call whichKey("<leader>ff", "Find file")
              call whichKey("<leader>fg", "Find grep")
              call whichKey("<leader>fh", "Find recent files")

              map <leader>fd <Action>(Find)
              map <leader>ff <Action>(GotoFile)
              map <leader>fg <Action>(FindInPath)
              map <leader>fh <Action>(RecentFiles)

              call whichKey("<leader>t", "Toggle")
              call whichKey("<leader>ta", "Toggle copilot")
              call whichKey("<leader>tb", "Toggle build")
              call whichKey("<leader>tg", "Toggle commit")
              call whichKey("<leader>tt", "Toggle terminal")

              map<leader>ta <Action>(ActivateGitHubCopilotChatToolWindow)
              map<leader>tb <Action>(ActivateBuildToolWindow)
              map<leader>tg <Action>(ActivateCommitToolWindow)
              map<leader>tt <Action>(ActivateTerminalToolWindow)

              call whichKey("<leader>b", "Buffers")
              call whichKey("<leader>bd", "Delete current buffer")
              call whichKey("<leader>bD", "Delete all buffers")

              map<leader>bd <Action>(CloseEditor)
              map<leader>bD <Action>(CloseAllEditors)

              call whichKey("<leader>c", "Code")
              call whichKey("<leader>cd", "Go to declaration")

              map<leader>cd <Action>(GotoDeclaration)

              nnoremap <tab> :action NextTab<cr>
              nnoremap <s-tab> :action PreviousTab<cr>
            '';
          };
        };
    };
}

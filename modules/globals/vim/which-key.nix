{
  den.default.os.programs.nixvim.plugins.which-key = {
    enable = true;
    settings = {
      preset = "helix";
      spec = [
        {
          __unkeyed-1 = "<leader><tab>";
          group = "tabs";
          mode = [
            "n"
            "x"
          ];
        }
        {
          __unkeyed-1 = "<leader>a";
          group = "ai";
          mode = [
            "n"
            "v"
          ];
        }
        {
          __unkeyed-1 = "<leader>ao";
          group = "opencode";
          mode = [
            "n"
            "x"
          ];
        }
        {
          __unkeyed-1 = "<leader>b";
          group = "buffer";
          mode = [
            "n"
            "x"
          ];
        }
        {
          __unkeyed-1 = "<leader>c";
          group = "code";
          mode = [
            "n"
            "x"
          ];
        }
        {
          __unkeyed-1 = "<leader>d";
          group = "debug";
          mode = [
            "n"
            "x"
          ];
        }
        {
          __unkeyed-1 = "<leader>dp";
          group = "profiler";
          mode = [
            "n"
            "x"
          ];
        }
        {
          __unkeyed-1 = "<leader>f";
          group = "file/find";
          mode = [
            "n"
            "x"
          ];
        }
        {
          __unkeyed-1 = "<leader>g";
          group = "git";
          mode = [
            "n"
            "x"
          ];
        }
        {
          __unkeyed-1 = "<leader>gh";
          group = "hunks";
          mode = [
            "n"
            "x"
          ];
        }
        {
          __unkeyed-1 = "<leader>q";
          group = "quit/session";
          mode = [
            "n"
            "x"
          ];
        }
        {
          __unkeyed-1 = "<leader>s";
          group = "search";
          mode = [
            "n"
            "x"
          ];
        }
        {
          __unkeyed-1 = "<leader>t";
          group = "toggle";
          mode = [
            "n"
            "x"
          ];
        }
        {
          __unkeyed-1 = "<leader>u";
          group = "ui";
          mode = [
            "n"
            "x"
          ];
        }
        {
          __unkeyed-1 = "<leader>w";
          group = "windows";
          mode = [
            "n"
            "x"
          ];
        }
        {
          __unkeyed-1 = "<leader>x";
          group = "diagnostics/quickfix";
          mode = [
            "n"
            "x"
          ];
        }
        {
          __unkeyed-1 = "[";
          group = "prev";
          mode = [
            "n"
            "x"
          ];
        }
        {
          __unkeyed-1 = "]";
          group = "next";
          mode = [
            "n"
            "x"
          ];
        }
        {
          __unkeyed-1 = "g";
          group = "goto";
          mode = [
            "n"
            "x"
          ];
        }
        {
          __unkeyed-1 = "gs";
          group = "surround";
          mode = [
            "n"
            "x"
          ];
        }
        {
          __unkeyed-1 = "<leader>sn";
          group = "+noice";
          mode = [
            "n"
            "x"
          ];
        }
        {
          __unkeyed-1 = "z";
          group = "fold";
          mode = [
            "n"
            "x"
          ];
        }
      ];
    };
  };
}

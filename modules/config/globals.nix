{
  den.default.homeManager =
    { config, ... }:
    {
      home.file."repositories/snowflake".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos";
    };
}

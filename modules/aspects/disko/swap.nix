{ lib, ... }:
{
  den.aspects.swap =
    { config, ... }:
    {
      imports = [ { options.call = lib.mkOption { type = with lib.types; functionTo attrs; }; } ];

      call =
        {
          resumeDevice ? true,
          discardPolicy ? "both", # pages, once
        }:
        {
          type = "swap";
          inherit resumeDevice discardPolicy;
        };
    };
}

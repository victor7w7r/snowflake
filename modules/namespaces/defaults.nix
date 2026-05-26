{ inputs, den, ... }:
{
  imports = [ (inputs.den.namespace "hosts-attrs" true) ];

  _module.args.__findFile = den.lib.__findFile;
}

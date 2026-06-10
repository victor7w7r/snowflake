{ inputs, ... }:
{
  imports = [ (inputs.den.namespace "initrd" false) ];
}

{ inputs, ... }:
{
  imports = [ (inputs.den.namespace "initrd-services" false) ];
}

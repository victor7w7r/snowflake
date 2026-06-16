{ inputs, ... }:
{
  imports = [ (inputs.den.namespace "kernel" false) ];
}

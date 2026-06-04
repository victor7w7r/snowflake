{ inputs, ... }:
{
  imports = [ (inputs.den.namespace "disko" false) ];
}

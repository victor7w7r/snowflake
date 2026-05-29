{ inputs, ... }:
{
  imports = [
    (inputs.den.namespace "generic" false)
    (inputs.den.namespace "handheld" false)
    (inputs.den.namespace "live" false)
    (inputs.den.namespace "main" false)
    (inputs.den.namespace "main-mac" false)
    (inputs.den.namespace "phone" false)
    (inputs.den.namespace "pizero" false)
    (inputs.den.namespace "server" false)
    (inputs.den.namespace "superlab" false)
    (inputs.den.namespace "wsl" false)
  ];
}

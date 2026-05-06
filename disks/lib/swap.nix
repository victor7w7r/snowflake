{
  resumeDevice ? true,
  discardPolicy ? "both", # pages, once
}:
{
  type = "swap";
  inherit resumeDevice discardPolicy;
}

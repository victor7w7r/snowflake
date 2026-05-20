{
  name,
  device,
  priority ? null,
  size ? "100%",
  content ? null,
  allowDiscards ? true,
  isForTest ? false,
  entireDisk ? false,
  postCreate ? "",
  postMount ? "",
  keyFile ? "/tmp/key.txt",
}:
let
  body = {
    inherit name content;
    postMountHook = postMount;
    type = "luks";
    settings = { inherit keyFile allowDiscards; };
    preCreateHook = (if isForTest then ''echo -n "test" > /tmp/key.txt'' else "");
    postCreateHook = ''
      cryptsetup config ${device} --label "${name}"
      ${postCreate}
    '';
  };
in
if entireDisk then
  body
else
  {
    inherit size priority;
    content = body;
  }

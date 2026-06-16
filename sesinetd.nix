{callPackage, writeScript, buildFHSEnv, unwrapped ? callPackage ./runtime.nix {}, ...}:
buildFHSEnv rec {
  name = "houdini-sesinetd-${unwrapped.version}";

  dieWithParent = true;
  unsharePid = false;

  targetPkgs = pkgs: with pkgs; [
    nettools
  ];

  extraBwrapArgs = [
    "--bind $1 /usr/lib64/sesi"
  ];

  extraBuildCommands = ''
    # we need to write extra dir to usr/lib
    # but it's write protected,
    # so we stash permissions, modify, then restore
    perms=$(stat -c %a $out/usr/lib64)
    chmod u+w $out/usr/lib64
    mkdir $out/usr/lib64/sesi

    chmod $perms $out/usr/lib64
  '';

  runScript = writeScript "${name}-sesinetd" ''
    shift
    exec ${unwrapped}/houdini/sbin/sesinetd "$@"
  '';
}

{callPackage, writeScript, buildFHSEnv, unwrapped ? callPackage ./runtime.nix {}, ...}:
buildFHSEnv rec {
  name = "houdini-sesinetd-${unwrapped.version}";

  dieWithParent = true;
  unsharePid = false;

  targetPkgs = pkgs: with pkgs; [
    nettools
  ];

  extraBwrapArgs = [
    "--bind $1 /usr/lib/sesi"
  ];

  extraBuildCommands = ''
    # we need to write extra dir to usr/lib
    # but it's write protected,
    # so we stash permissions, modify, then restore
    perms=$(stat -c %a usr/lib)
    chmod u+w usr/lib
    mkdir usr/lib/sesi

    chmod $perms usr/lib
  '';

  runScript = writeScript "${name}-sesinetd" ''
    shift
    exec ${unwrapped}/houdini/sbin/sesinetd "$@"
  '';
}

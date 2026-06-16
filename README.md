my fork of houdini package from nixpkgs

all important changes are pushed to nixpkgs

# Building

To be able to build houdini you need to download a corresponding build installer from [sidefx site](https://www.sidefx.com/download/daily-builds/?production=true),
because SideFX does not allow to do that automatically without registration.

Add downloaded installer to the store with `nix-store --add-fixed sha256 houdini-19.0.720-linux_x86_64_gcc9.3.tar.gz` (with proper filename of course)

then you can run corresponding houdini version without cloning repo or downloading anything
with simple command:

`nix run github:pedohorse/houdini-nix#houdini-19_0_720 houdini`

You can build the flake's output instead with: 

`nix build github:pedohorse/houdini-nix#houdini-19_0_720`

and have some houdini binaries available in `./result/bin`

# Running

There are several ways you can run houdini with this flake.

## Building and using ./result

After building with command like `nix build github:pedohorse/houdini-nix#houdini-19_0_720`, 
you will have the usual `result` symlink created. all (hopefully) important binaries are exposed in `./result/bin` directory.

This creats a more usual file structure, to which you can point your pipeline usual tools, that expect to run binaries directly

## Running flake

You can also run the flake's outputs directly, as in

* `nix run github:pedohorse/houdini-nix#houdini-19_5_569 houdini`
* `nix run github:pedohorse/houdini-nix#houdini-19_5_569 houdinifx`
* `nix run github:pedohorse/houdini-nix#houdini-19_5_569 houdinicore`
* etc

> [!Note]
> not all houdini's binaries are exposed now, only the ones deemed "useful", so feel free to open issue in case something you need is missing

## On sesinetd:

`sesinetd` is houdini's licensing server. There is a special set of flake outputs to run it.
You need to provide the script with a path to a writeable directory where the licenses are to be stored.

`nix run github:pedohorse/houdini-nix#sesinetd-19_5_569 -- /path/to/lic/dir --other sesinetd -arg uments`

for example, an easy way to run license server from houdini version 19.5.733, as your user named `artist`, and store licenses in relative dir `./hlicenses` you run:

`nix run github:pedohorse/houdini-nix#sesinetd-19_5_773 -- ./hlicenses --user artist --group artist -D`

this will run license server in foreground (`-D` flag) in the terminal, so you can kill it with Ctrl+C

# Notes:

currently this flake provides onlt the following versions:

* 19.0.720
* 19.5.569
* 19.5.640
* 19.5.716
* 19.5.773
* 20.0.506
* 20.0.547
* 20.0.590
* 20.0.625
* 20.0.653
* 20.0.688
* 20.5.278
* 20.5.332
* 20.5.370
* 20.5.410
* 20.5.445
* 20.5.487
* 20.5.522
* 20.5.550
* 20.5.613
* 20.5.684
* 21.0.440
* 21.0.512

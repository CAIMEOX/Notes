# shell.nix

{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.python39Packages.virtualenv
    (pkgs.python39.withPackages (ps: [ ps.lark ]))
  ];
}

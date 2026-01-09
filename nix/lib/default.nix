{ lib, ... }:
{
  types = import ./types.nix { inherit lib; } // lib.types;

  either = left: right: if left != null then left else right;
}

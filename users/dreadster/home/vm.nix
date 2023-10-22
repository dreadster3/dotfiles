{config, lib, pkgs, ...}:
{
	imports = [
		./default.nix
	];

	home.packages = with pkgs; [
		(pkgs.callPackage ../../../derivations/x11eventcallbacks.nix {})
	];
}

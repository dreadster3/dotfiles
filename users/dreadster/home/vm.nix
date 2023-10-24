{config, lib, pkgs, ...}:
{
	imports = [
		./default.nix
		../../../services/homemanager/x11eventcallbacks.nix
	];
}

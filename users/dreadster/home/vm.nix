{config, lib, pkgs, ...}:
{
	imports = [
		./default.nix
		../../../modules/homemanager/x11eventcallbacks.nix
	];
}

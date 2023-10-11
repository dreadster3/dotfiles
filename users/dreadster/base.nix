{config, lib, pkgs, ...}:

{
	users.users.dreadster = {
		shell = pkgs.zsh;
		isNormalUser = true;
		description = "Admin";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = with pkgs; [];
	};

	home-manager.users.dreadster = (import ./home.nix);
}

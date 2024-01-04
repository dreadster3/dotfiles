{config, lib, pkgs, ...}:
{
  programs = {
    zsh = {
      enable = true;
    };
  };

  environment = {
	  variables = {
		  NIX_BUILD_SHELL = pkgs.zsh + "/bin/zsh";
	  };
  };
}

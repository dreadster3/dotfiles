{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.nixos.llama-cpp;
  llamaPackage = pkgs.llama-cpp.override {
    cudaSupport = true;
    blasSupport = true;
  };
  sdPackage = pkgs.stable-diffusion-cpp-cuda;
in
{
  options = {
    modules.nixos.llama-cpp = {
      enable = mkEnableOption "llama-cpp";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      llamaPackage
      llama-swap
      sdPackage
    ];

    services.llama-swap = {
      enable = true;
      settings =
        let
          llama-server = getExe' llamaPackage "llama-server";
          sd-server = getExe' sdPackage "sd-server";
        in
        {
          models = {
            "qwen3.6-35b-a3b" = {
              cmd = lib.concatStringsSep " " [
                llama-server
                "--model /opt/models/Qwen3.6-35B-A3B-UD-Q4_K_M.gguf"
                "--mmproj /opt/models/Qwen3.6-35B-A3B-UD-Q4_K_M-mmproj_BF16.gguf"
                "--port \${PORT}"
                "--alias qwen3.6-35b-a3b"
                "-c 131072"
                "-n 32768"
                "--no-context-shift"
                "--temp 0.6"
                "--top-p 0.95"
                "--top-k 20"
                "--repeat-penalty 1.00"
                "--presence-penalty 0.00"
                "--fit on"
                "-fa on"
                "-ctk q8_0"
                "-ctv q8_0"
                "--chat-template-kwargs '{\"preserve_thinking\": true}'"
              ];
            };

            "flux.2-klein-4b" = {
              cmd = lib.concatStringsSep " " [
                sd-server
                "--diffusion-model /opt/models/flux-2-klein-4b-Q4_K_M.gguf"
                "--vae /opt/models/flux2-klein-vae.safetensors"
                "--llm /opt/models/Qwen3-4B-Q4_K_M.gguf"
                "--listen-port \${PORT}"
                "--listen-ip 127.0.0.1"
                "--diffusion-fa"
                "--cfg-scale 1.0"
                "--steps 4"
                "--offload-to-cpu"
                "-v"
              ];
              checkEndpoint = "/";
            };
          };
        };
    };
  };
}

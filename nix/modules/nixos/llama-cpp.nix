{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.nixos.llama-cpp;
  llamaPackage = pkgs.llama-cpp-vulkan;
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
      # sdPackage
    ];

    services.llama-swap = {
      enable = true;
      settings =
        let
          llama-server = getExe' llamaPackage "llama-server";
          # sd-server = getExe' sdPackage "sd-server";
        in
        {
          models = {
            "qwen3.5-4b" = {
              cmd = lib.concatStringsSep " " [
                llama-server
                "--model /opt/models/Qwen3.5-4B-Q4_K_M.gguf"
                "--mmproj /opt/models/Qwen3.5-4B-mmproj-F32.gguf"
                "--port \${PORT}"
                "--alias qwen3.5-4b"
                "-c 131072"
                "-n 32768"
                "--no-context-shift"
                "--temp 0.6"
                "--top-p 0.95"
                "--top-k 20"
                "--min-p 0.0"
                "--presence-penalty 0.00"
                "--repeat-penalty 1.00"
                "--fit on"
                "-fa on"
                "-ctk q8_0"
                "-ctv q8_0"
                "--chat-template-kwargs '{\"preserve_thinking\": true}'"
              ];
            };

            "qwen3-embedding-0.8b" = {
              cmd = lib.concatStringsSep " " [
                llama-server
                "--embedding"
                "--pooling last"
                "-c 8192"
                "-ub 8192"
                "--port \${PORT}"
                "--alias qwen3-embedding-0.6b"
              ];
            };

            "laya" = {
              cmd = lib.concatStringsSep " " [
                llama-server
                "--model /opt/models/Laya-BF16.gguf"
                "--port \${PORT}"
                "--alias laya"
              ];
            };

            # "flux.2-klein-4b" = {
            #   cmd = lib.concatStringsSep " " [
            #     sd-server
            #     "--diffusion-model /opt/models/flux-2-klein-4b-Q4_K_M.gguf"
            #     "--vae /opt/models/flux2-klein-vae.safetensors"
            #     "--llm /opt/models/Qwen3-4B-Q4_K_M.gguf"
            #     "--listen-port \${PORT}"
            #     "--listen-ip 127.0.0.1"
            #     "--diffusion-fa"
            #     "--cfg-scale 1.0"
            #     "--steps 4"
            #     "--offload-to-cpu"
            #     "-v"
            #   ];
            #   checkEndpoint = "/";
            # };
          };
          routing.router = {
            use = "group";
            settings = {
              groups = {
                always-on = {
                  swap = false;
                  exclusive = true;
                  members = [
                    "qwen3.5-4b"
                    "qwen3-embedding-0.8b"
                    "laya"
                  ];
                };
              };
            };
          };
        };
    };
  };
}

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
          models =
            let
              qwen35 = name: model: mmproj: {
                cmd = lib.concatStringsSep " " [
                  llama-server
                  "--model ${model}"
                  "--mmproj ${mmproj}"
                  "--port \${PORT}"
                  "--alias ${name}"
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
            in
            {
              "qwen3.5-0.8b" =
                qwen35 "qwen3.5-0.8b" "/opt/models/Qwen3.5-0.8B-BF16.gguf"
                  "/opt/models/Qwen3.5-0.8B-mmproj-F32.gguf";

              "qwen3.5-2b" =
                qwen35 "qwen3.5-2b" "/opt/models/Qwen3.5-2B-BF16.gguf"
                  "/opt/models/Qwen3.5-2B-mmproj-F32.gguf";

              "qwen3.5-4b" =
                qwen35 "qwen3.5-4b" "/opt/models/Qwen3.5-4B-Q4_K_M.gguf"
                  "/opt/models/Qwen3.5-4B-mmproj-F32.gguf";

              "qwen3-embedding-0.6b" = {
                cmd = lib.concatStringsSep " " [
                  llama-server
                  "--model /opt/models/qwen3-embedding-0.6b-q8_0.gguf"
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

              "qwen3-reranker-0.6b" = {
                cmd = lib.concatStringsSep " " [
                  llama-server
                  "--model /opt/models/qwen3-reranker-0.6b-q8_0.gguf"
                  "--reranking"
                  "--pooling rank"
                  "-c 8192"
                  "-ub 8192"
                  "--port \${PORT}"
                  "--alias qwen3-reranker-0.6b"
                ];
              };
            };

          routing.router = {
            use = "group";
            settings = {
              groups = {
                always-on = {
                  swap = false; # all members can run at the same time
                  exclusive = false; # don't unload the qwen group
                  persistent = true; # never unloaded by other groups
                  members = [
                    "qwen3-embedding-0.6b"
                    "qwen3-reranker-0.6b"
                    "laya"
                  ];
                };

                "qwen3.5" = {
                  swap = true; # only one qwen3.5 size at a time
                  exclusive = false; # don't unload the always-on group
                  members = [
                    "qwen3.5-0.8b"
                    "qwen3.5-2b"
                    "qwen3.5-4b"
                  ];
                };
              };
            };
          };
        };
    };
  };
}

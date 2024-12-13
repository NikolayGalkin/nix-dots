{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf types;
  inherit (lib.${namespace}) mkOpt mkBoolOpt enabled;
  inherit (config.${namespace}) user;

  cfg = config.${namespace}.programs.terminal.tools.git;
in
{
  options.${namespace}.programs.terminal.tools.git = {
    enable = mkBoolOpt false "Whether or not to enable git.";
    userName = mkOpt types.str user.full-name "The name to configure git with.";
    userEmail = mkOpt types.str user.email "The email to configure git with.";
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      inherit (cfg) userName userEmail;

      aliases = {
        co = "checkout";
        ci = "commit";
        br = "branch";
        st = "status";
      };

      extraConfig = {
        init = {
          defaultBranch = "main";
          defaultRemote = "origin";
        };

        lfs = enabled;

        pull = {
          rebase = true;
        };
      };

      delta = {
        enable = true;
        catppuccin.enable = true;
        options = {
          line-numbers = true;
          navigate = true;
          side-by-side = true;
        };
      };
    };
  };
}

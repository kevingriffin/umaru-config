{ config, lib, pkgs, ... }:

# Puppet style imperative config for setting sshd settings
let
  cfg = config.services.openssh;

  boolToStr = x: if x then "yes" else "no";

  assertedValues =
    (lib.optionalAttrs (cfg.passwordAuthentication != null) {
      "PasswordAuthentication" = boolToStr cfg.passwordAuthentication;
    }) //
    (lib.optionalAttrs (cfg.challengeResponseAuthentication != null) {
      "ChallengeResponseAuthentication" = boolToStr cfg.challengeResponseAuthentication;
    });

  # Manually specify only ssh and how to read it. Saves me ~450ms on
  # activation.
  augeasScript = pkgs.writeText "augeas-configure-ssh" ''
    set /augeas/load/Sshd/lens "Sshd.lns"
    set /augeas/load/Sshd/incl "/etc/ssh/sshd_config"

    load

    ${lib.concatStrings (lib.mapAttrsToList (k: v: ''
      set /files/etc/ssh/sshd_config/${k} "${v}"
    '') assertedValues)}

    save
  '';
in
{
  options = {
    services.openssh = {
      passwordAuthentication = lib.mkOption {
        type = lib.types.nullOr lib.types.bool;
        default = null;
      };

      challengeResponseAuthentication = lib.mkOption {
        type = lib.types.nullOr lib.types.bool;
        default = null;
      };
    };
  };

  config = lib.mkIf (assertedValues != {}) {
    assertions = [{
      assertion = cfg.passwordAuthentication == false -> cfg.challengeResponseAuthentication == false;
      message = "passwordAuthentication might be ineffective if challengeResponseAuthentication is enabled";
    }];

    system.activationScripts.extraActivation.text = ''
      ${pkgs.augeas}/bin/augtool --noautoload --noload -f ${augeasScript}
    '';
  };
}

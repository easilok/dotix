{ config, pkgs, ... }: {
    services.gpg-agent = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
        grabKeyboardAndMouse = false;
        # Timeout (seconds) between activity
        defaultCacheTtl = 60 * 60 * 24; # 1 day
        # Timeout (seconds) to request password
        maxCacheTtl = 60 * 60 * 24 * 7; # 1 week
        extraConfig = ''
            allow-emacs-pinentry
            allow-loopback-pinentry
            '';
    };
}


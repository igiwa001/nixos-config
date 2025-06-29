{
  lib,
  config,
  ...
}:
with builtins; let
  cfg = config.settings.wallpaper;
  user = config.settings.user;
  wallpapersDir = ../../wallpapers;
  avaliableWallpapers = attrNames (readDir wallpapersDir);
  wrapList = list: [(elemAt list (length list - 1))] ++ list ++ [(head list)];
  wallpapers = concatStringsSep " " avaliableWallpapers;
  wallpapersWrapped = concatStringsSep " " (wrapList avaliableWallpapers);
in {
  options.settings.wallpaper = {
    default = lib.mkOption {
      type = lib.types.str;
      default = "";
    };

    path = lib.mkOption {
      type = lib.types.path;
      default = "${user.homeDirectory}/.config/wallpaper";
    };

    onChange = lib.mkOption {
      type = lib.types.lines;
      default = "";
    };
  };

  config.systemd.user.services.wallpaper = {
    enable = true;
    wantedBy = ["default.target"];
    script = ''
      WALLPAPER=${cfg.default}

      if [ -z $WALLPAPER ]; then
        WALLPAPER=$(
          echo "${wallpapers}" |\
          sed "s/ /\n/g" |\
          shuf -n 1
        )
      fi

      if [ 1 -ne $(
        echo "${wallpapers}" |\
        sed "s/ /\n/g" |\
        grep -s ^$WALLPAPER$ -c
      ) ]; then
        echo "Invalid wallpaper: $WALLPAPER"
        exit 1
      fi

      ln -sf ${wallpapersDir}/$WALLPAPER ${cfg.path}
    '';
  };

  config.settings.home-manager.programs.bash.bashrcExtra = ''
    wallpaper_get() {
      basename $(readlink ${cfg.path})
    }

    wallpaper_set() {
      if [ 1 -ne $(
        echo "${wallpapers}" |\
        sed "s/ /\n/g" |\
        grep -s ^$1$ -c
      ) ]; then
        echo "Invalid wallpaper"
        return 1
      fi

      ln -sf ${wallpapersDir}/$1 ${cfg.path}

      ${cfg.onChange}
    }

    wallpaper_list() {
      WALLPAPER=$(wallpaper_get)

      for wallpaper in $(
        echo "${wallpapers}" |\
        sed "s/ /\n/g"
      ); do
        if [ $WALLPAPER = $wallpaper ]
        then
          PREFIX=" * "
        else
          PREFIX="   "
        fi

        echo "$PREFIX$wallpaper"
      done
    }

    wallpaper_next() {
      WALLPAPER=$(wallpaper_get)

      wallpaper_set $(
        echo "${wallpapersWrapped}" |\
        sed "s/ /\n/g" |\
        grep $WALLPAPER -A 1 --no-group-separator |\
        grep $WALLPAPER -v |\
        head -n 1 \
      )
    }

    wallpaper_prev() {
      WALLPAPER=$(wallpaper_get)

      wallpaper_set $(
        echo "${wallpapersWrapped}" |\
        sed "s/ /\n/g" |\
        grep $WALLPAPER -B 1 --no-group-separator |\
        grep $WALLPAPER -v |\
        head -n 1 \
      )
    }

    wallpaper_rand() {
      WALLPAPER=$(wallpaper_get)

      wallpaper_set $(
        echo "${wallpapers}" |\
        sed "s/ /\n/g" |\
        grep -v $WALLPAPER |\
        shuf -n 1 \
      )
    }
  '';
}

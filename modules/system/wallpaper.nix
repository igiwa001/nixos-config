{
  lib,
  config,
  ...
}: let
  cfg = config.settings.wallpaper;
in {
  options.settings.wallpaper = {
    default = lib.mkOption {
      type = lib.types.str;
      default = "hyprland.png";
    };

    directory = lib.mkOption {
      type = lib.types.str;
      default = ".config/wallpapers";
    };

    onChange = lib.mkOption {
      type = lib.types.lines;
      default = "";
    };
  };

  config.settings.home-manager = {
    home = {
      file.wallpapers = {
        enable = true;
        recursive = true;
        source = ../../wallpapers;
        target = cfg.directory;
      };
      sessionVariables.WALLPAPER = cfg.default;
    };

    programs.bash.bashrcExtra = let
      wallpaperList = ''
        $(
          find ~/${cfg.directory} \
          -mindepth 1 -maxdepth 1 \
          -type l -exec basename {} \; |\
          sed "s/ /\n/g" |\
          sort \
        )'';
      wallpaperListLooping = ''
        $(
          LIST=${wallpaperList}
          set -- $LIST
          echo ${"\${@: -1} $LIST $1 "}
        )'';
    in ''
      wallpaper_list() {
        WALLPAPERS=${wallpaperList}

        for wallpaper in $WALLPAPERS
        do
          if [ $WALLPAPER = $wallpaper ]
          then
            PREFIX=" * "
          else
            PREFIX="   "
          fi

          echo "$PREFIX$wallpaper"
        done
      }

      wallpaper_get() {
        echo $WALLPAPER
      }

      wallpaper_set() {

        if [ ! -f ~/${cfg.directory}/$1 ]; then
          echo "Invalid wallpaper"
          return 1
        fi

        export WALLPAPER=$1
        ${cfg.onChange}
      }

      wallpaper_next() {
        WALLPAPERS=${wallpaperListLooping}

        NEXT=$( \
          echo $WALLPAPERS |\
          sed "s/ /\n/g" |\
          grep $WALLPAPER -A 1 --no-group-separator |\
          grep $WALLPAPER -v |\
          head -n 1 \
        )

        wallpaper_set $NEXT
      }

      wallpaper_prev() {
        WALLPAPERS=${wallpaperListLooping}

        PREV=$( \
          echo $WALLPAPERS |\
          sed "s/ /\n/g" |\
          grep $WALLPAPER -B 1 --no-group-separator |\
          grep $WALLPAPER -v |\
          head -n 1 \
        )

        wallpaper_set $PREV
      }

      wallpaper_rand() {
        WALLPAPERS=${wallpaperList}

        RAND=$( \
          echo $WALLPAPERS |\
          sed "s/ /\n/g" |\
          grep -v $WALLPAPER |\
          shuf -n 1 \
        )

        wallpaper_set $RAND
      }
    '';
  };
}

{ fetchFromGitHub, spotify, spotify-unwrapped
, gtk3, libxkbcommon # spotify-unwrapped-1.1.55.498
  # copy paste from spotify/default.nix:
, fetchurl, lib, stdenv, squashfsTools, xorg, alsaLib, makeWrapper, openssl, freetype
, glib, pango, cairo, atk, gdk-pixbuf, gtk2, cups, nspr, nss, libpng, libnotify
, libgcrypt, systemd, fontconfig, dbus, expat, ffmpeg_3, curl, zlib, gnome3
, at-spi2-atk, at-spi2-core, libpulseaudio, libdrm, mesa
}:
let
  curlWithGnutls = curl.override { gnutlsSupport = true; sslSupport = false; }; # provides libcurl-gnutls.so.4
  # warning message: libcurl-gnutls.so.4: no version information available
  # spotify seems to want curl_3 = libcurl 7.15.x = older than 2006-10
  # readelf -s /nix/store/*-spotify-unwrapped-*/share/spotify/.spotify-wrapped | grep -i curl
  # 520: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND [...]@CURL_GNUTLS_3 (19)

  # copy paste from spotify/default.nix:
  deps = [
    alsaLib
    atk
    at-spi2-atk
    at-spi2-core
    cairo
    cups
    #curl # error: libcurl-gnutls.so.4: No such file or directory
    curlWithGnutls
    dbus
    expat
    ffmpeg_3
    fontconfig
    freetype
    gdk-pixbuf
    glib
    gtk2
    gtk3 libxkbcommon # spotify-unwrapped-1.1.55.498
    libdrm
    libgcrypt
    libnotify
    libpng
    libpulseaudio
    mesa
    nss
    pango
    stdenv.cc.cc
    systemd
    xorg.libX11
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXi
    xorg.libXrandr
    xorg.libXrender
    xorg.libXScrnSaver
    xorg.libXtst
    xorg.libxcb
    xorg.libSM
    xorg.libICE
    zlib
  ];

  # we need Chromium Embedded Framework (cef) with the same version that spotify was built with
  # we also need `include/cef_config.h` (etc.) which are only distributed in the 300 MB cef binary tarball
  # only fetch tarball. extract manually to save diskspace
  fetch-cef-tar = { spotify }:
    let
      spotify-version-long = (builtins.parseDrvName spotify.name).version; # sample: "1.1.26.501.gbe11e53b"
      spotify-version = builtins.elemAt (builtins.match "([^.]+\.[^.]+\.[^.]+)\..+" spotify-version-long) 0; # -> 1.1.26

      spotify-unwrapped-version-long = (builtins.parseDrvName spotify-unwrapped.name).version;
      spotify-unwrapped-version = spotify-unwrapped.version;

      cef-version =
        #builtins.trace "spotify-adblock-linux: spotify-version = ${spotify-version}"
        builtins.getAttr spotify-version cef-version-of-spotify-version;
      cef-build =
        #builtins.trace "spotify-adblock-linux: cef-version = ${cef-version}"
        builtins.getAttr cef-version cef-build-of-cef-version;
      cef-sha256 = builtins.getAttr cef-file cef-sha256-of-file;

      cef-platform = "linux64";
      cef-file = "cef_binary_${cef-build}_${cef-platform}_minimal.tar.bz2";
      cef-file-urlencoded = builtins.replaceStrings ["+"] ["%2B"] cef-file;
      cef-url = "https://cef-builds.spotifycdn.com/${cef-file-urlencoded}";

      cef-sha256-of-file = {
        "cef_binary_87.1.14+ga29e9a3+chromium-87.0.4280.141_linux64_minimal.tar.bz2" = "0da8mz9898rflxxhz6qif2z89p88ak2zc3a2cgmvdcsy1fvdnd4s";
        "cef_binary_85.3.13+gcd6cbe0+chromium-85.0.4183.121_linux64_minimal.tar.bz2" = "WiyOHRhhEe5iGP7NC/jyKWZ3AtF4S07BlB7CHAAv8wQ=";
        "cef_binary_79.1.35+gfebbb4a+chromium-79.0.3945.130_linux64_minimal.tar.bz2" = "0k00kav51khnn4wbq4z0aqmg0w57k92wdxi5nvas824iblz5yd79";
        "cef_binary_74.1.19+gb62bacf+chromium-74.0.3729.157_linux64_minimal.tar.bz2" = "0v3540kq4y68gq7mb4d8a9issm363lm5ngrd6d96pcc7vckkw4wn";
        # TODO add more checksums (error: attribute 'cef_binary_*_minimal.tar.bz2' missing)
        # TODO prettier error messages on missing checksums?
        #"cef_binary_1234.tar.bz2" = "0000000000000000000000000000000000000000000000000000";
      };

      # generated by generate-cef-build-of-spotify-version.js
      cef-version-of-spotify-version = {
        "1.1.56" = "87.1.14"; "1.1.55" = "87.1.14"; "1.1.54" = "87.1.14"; "1.1.53" = "87.1.14";
        "1.1.52" = "86.0.23"; "1.1.51" = "86.0.23"; "1.1.48" = "86.0.23"; "1.1.47" = "86.0.23";
        "1.1.46" = "85.3.13"; "1.1.45" = "85.3.13";
        "1.1.44" = "85.3.11";
        "1.1.43" = "85.3.9";
        "1.1.42" = "84.3.8"; "1.1.41" = "84.3.8"; "1.1.40" = "84.3.8";
        "1.1.39" = "83.5.0";
        "1.1.38" = "83.4.0"; "1.1.37" = "83.4.0";
        "1.1.36" = "83.3.12";
        "1.1.35" = "81.3.8"; "1.1.34" = "81.3.8";
        "1.1.33" = "80.1.14";
        "1.1.32" = "79.1.35"; "1.1.31" = "79.1.35"; "1.1.30" = "79.1.35"; "1.1.29" = "79.1.35"; "1.1.28" = "79.1.35"; "1.1.27" = "79.1.35"; "1.1.26" = "79.1.35";
        "1.1.25" = "78.3.4"; "1.1.24" = "78.3.4"; "1.1.22" = "78.3.4";
        "1.1.21" = "76.1.12"; "1.1.20" = "76.1.12"; "1.1.19" = "76.1.12"; "1.1.18" = "76.1.12"; "1.1.17" = "76.1.12";
        "1.1.16" = "75.1.4"; "1.1.15" = "75.1.4"; "1.1.14" = "75.1.4";
        "1.1.12" = "75.0.11";
        "1.1.10" = "74.1.19"; "1.1.9" = "74.1.19";
      };

      # generated by generate-cef-build-of-spotify-version.js
      cef-build-of-cef-version = {
        "87.1.14" = "87.1.14+ga29e9a3+chromium-87.0.4280.141";
        "86.0.23" = "86.0.23+ga2c2edf+chromium-86.0.4240.193";
        "85.3.13" = "85.3.13+gcd6cbe0+chromium-85.0.4183.121";
        "85.3.11" = "85.3.11+g3644604+chromium-85.0.4183.102";
        "85.3.9" = "85.3.9+gb045a6e+chromium-85.0.4183.102";
        "84.3.8" = "84.3.8+gc8a556f+chromium-84.0.4147.105";
        "83.5.0" = "83.5.0+gbf03589+chromium-83.0.4103.106";
        "83.4.0" = "83.4.0+gfd6631b+chromium-83.0.4103.106";
        "83.3.12" = "83.3.12+g0889ff0+chromium-83.0.4103.97";
        "81.3.8" = "81.3.8+g1a0137c+chromium-81.0.4044.138";
        "80.1.14" = "80.1.14+ga33bdbc+chromium-80.0.3987.149";
        "79.1.35" = "79.1.35+gfebbb4a+chromium-79.0.3945.130";
        "78.3.4" = "78.3.4+ge17bba6+chromium-78.0.3904.108";
        "76.1.12" = "76.1.12+gc6d4d85+chromium-76.0.3809.132";
        "75.1.4" = "75.1.4+g4210896+chromium-75.0.3770.100";
        "75.0.11" = "75.0.11+gf50b3c2+chromium-75.0.3770.100";
        "74.1.19" = "74.1.19+gb62bacf+chromium-74.0.3729.157";
      };
    in
    assert lib.asserts.assertMsg
      (spotify-version-long == spotify-unwrapped-version-long)
      ''error: version mismatch:
        spotify           ${spotify-version-long}
        spotify-unwrapped ${spotify-unwrapped-version-long}'';
    fetchurl {
      url = cef-url;
      name = cef-file;
      sha256 = cef-sha256;
    };
in

stdenv.mkDerivation rec {
  pname = "spotify-adblock-linux";
  version = "1.4";

  src = fetchFromGitHub {
    owner = "abba23";
    repo = "spotify-adblock-linux";
    rev = "v${version}";
    sha256 = "Pcbtyld/D7UoynkevX4wb/mXBFbvz7uT9bD/D55h3Ko=";
  };

  cef-tar = fetch-cef-tar { spotify = spotify; };

  postUnpack = ''
    # extract include/. takes ~1 minute
    echo unpacking source from ${cef-tar}
    tar -C source/ -xf ${cef-tar} --wildcards '*/include' --strip-components=1

    # fix "undefined symbol: cef_string_userfree_utf16_free"
    sed -i 's|^LDLIBS=-ldl$|LDLIBS=-ldl -L${spotify-unwrapped}/share/spotify/ -lcef|' source/Makefile
  '';

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/{lib,bin}

    cp spotify-adblock.so $out/lib/

    libdir=${spotify-unwrapped}/lib/spotify
    librarypath="${lib.makeLibraryPath deps}:$libdir"

    makeWrapper ${spotify-unwrapped}/share/spotify/.spotify-wrapped $out/bin/spotify-adblock-linux \
      --prefix LD_LIBRARY_PATH : "$librarypath" \
      --prefix PATH : "${gnome3.zenity}/bin" \
      --suffix LD_PRELOAD : "$out/lib/spotify-adblock.so"

    # Desktop file
    # based on spotify/default.nix
    mkdir -p $out/share/applications
    cp ${spotify-unwrapped}/share/spotify/spotify.desktop $out/share/applications/spotify-adblock-linux.desktop
    # fix Icon line in the desktop file (#48062)
    sed -i "
      s/^Icon=.*/Icon=spotify-client/;
      s/Exec=spotify/Exec=spotify-adblock-linux/;
      s/Name=Spotify/Name=Spotify Adblock Linux/;
    " $out/share/applications/spotify-adblock-linux.desktop
    # Icons
    for i in 16 22 24 32 48 64 128 256 512; do
      ixi="$i"x"$i"
      mkdir -p "$out/share/icons/hicolor/$ixi/apps"
      ln -s "${spotify-unwrapped}/share/spotify/icons/spotify-linux-$i.png" \
        "$out/share/icons/hicolor/$ixi/apps/spotify-client.png"
    done

    runHook postInstall
  '';

  meta = with lib; {
    description = "Spotify adblocker for Linux";
    homepage = "https://github.com/abba23/spotify-adblock-linux";
    license = licenses.gpl3Only;
    platforms = platforms.linux;
  };
}

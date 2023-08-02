# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage

{ pkgs ? import <nixpkgs> { } }:

/*
# pin nixpkgs
{
  pkgs ? import (fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/f5dad40450d272a1ea2413f4a67ac08760649e89.tar.gz";
    sha256 = "06nq3rn63csy4bx0dkbg1wzzm2jgf6cnfixq1cx4qikpyzixca6i";
  }) { }
}:
*/

pkgs.lib.makeScope pkgs.newScope (self: let inherit (self) callPackage; in rec {

  # library functions
  lib = pkgs.lib // (import ./lib { inherit pkgs; });

  # NixOS modules
  modules = import ./modules;

  # nixpkgs overlays
  overlays = import ./overlays;

  #spotify-adblock-linux = callPackage ./pkgs/spotify-adblock-linux { };

  spotify-adblock = callPackage ./pkgs/spotify-adblock/spotify-adblock.nix { };

  ricochet-refresh = pkgs.libsForQt5.callPackage ./pkgs/ricochet-refresh/default.nix { };

  aether-server = pkgs.libsForQt5.callPackage ./pkgs/aether-server/default.nix { };

  archive-org-downloader = callPackage ./pkgs/archive-org-downloader/default.nix { };

  rpl = callPackage ./pkgs/rpl/default.nix { };

  svn2github = callPackage ./pkgs/svn2github/default.nix { };

  recaf-bin = callPackage ./pkgs/recaf-bin/default.nix { };

  github-downloader = callPackage ./pkgs/github-downloader/default.nix { };

  oci-image-generator = callPackage ./pkgs/oci-image-generator-nixos/default.nix { };

  /*
  linux-firecracker = callPackage ./pkgs/linux-firecracker { };
  FIXME eval error
    linuxManualConfig

    error: cannot import '/nix/store/wncs0mpydwbj89bljzfldk5vij0dalwy-config.nix', since path '/nix/store/ngggbr62d4nk754m3bj3s5fy11j1ginn-config.nix.drv' is not valid

           at /nix/store/hlzqh8yqzrzp2knrrndf9133k6hxsbjv-source/pkgs/os-specific/linux/kernel/manual-config.nix:7:28:

                6| let
                7|   readConfig = configfile: import (runCommand "config.nix" {} ''
                 |                            ^
  */

  # FIXME gnome.gtk is missing
  #hazel-editor = callPackage ./pkgs/hazel-editor { };

  brother-hll3210cw = callPackage ./pkgs/brother-hll3210cw { };

  rasterview = callPackage ./pkgs/rasterview { };

  srtgen = callPackage ./pkgs/srtgen { };

  gaupol = callPackage ./pkgs/gaupol/gaupol.nix { };

  autosub-by-abhirooptalasila = callPackage ./pkgs/autosub-by-abhirooptalasila/autosub.nix { };

  proftpd = callPackage ./pkgs/proftpd/proftpd.nix { };

  pyload = callPackage ./pkgs/pyload/pyload.nix { };

  rose = callPackage ./pkgs/rose/rose.nix { };

  tg-archive = callPackage ./pkgs/tg-archive/tg-archive.nix { };

  jaq = callPackage ./pkgs/jaq/jaq.nix { };

  # FIXME error: attribute 'gtk' missing
  #aegisub = pkgs.libsForQt5.callPackage ./pkgs/aegisub/aegisub.nix { };

  # example-package = callPackage ./pkgs/example-package { };
  # some-qt5-package = pkgs.libsForQt5.callPackage ./pkgs/some-qt5-package { };
  # ...

  redis-commander = callPackage ./pkgs/redis-commander/redis-commander.nix { };

  yacy = callPackage ./pkgs/yacy/yacy.nix { };

  flutter-engine = callPackage ./pkgs/flutter-engine/flutter-engine.nix { };

  libalf = callPackage ./pkgs/libalf/libalf.nix { };

  python3 = pkgs.python3 // {
    # FIXME scope with new callPackage
    #pkgs = (pkgs.python3.pkgs or {}) // ({
    # error: attribute 'buildPythonApplication' missing: python3.pkgs.buildPythonApplication
    #pkgs = (pkgs.python3.pkgs or {}) // lib.makeScope pkgs.newScope (self: with self; {
    # https://github.com/NixOS/nixpkgs/commit/632c4f2c9ba1f88cd5662da7bedf2ca5f0cda4a9 # add scope
    pkgs = lib.makeScope pkgs.newScope (self: with self; (pkgs.python3.pkgs or {}) // {

      # fix recursion
      python3.pkgs = self;
      python3Packages = self;

      aalpy = python3.pkgs.callPackage ./pkgs/python3/pkgs/aalpy/aalpy.nix { };

      auditok = python3.pkgs.callPackage ./pkgs/python3/pkgs/auditok/auditok.nix { };

      pysubs2 = python3.pkgs.callPackage ./pkgs/python3/pkgs/pysubs2/pysubs2.nix { };

      ete3 = python3.pkgs.callPackage pkgs/python3/pkgs/ete3/ete3.nix { };

      faust-cchardet = python3.pkgs.callPackage ./pkgs/python3/pkgs/faust-cchardet/faust-cchardet.nix { };

      pocketsphinx = python3.pkgs.callPackage ./pkgs/python3/pkgs/pocketsphinx/pocketsphinx.nix {
        pkgs = pkgs // {
          # fix: error: pocketsphinx has been removed: unmaintained
          inherit pocketsphinx;
        };
      };

      speechrecognition = python3.pkgs.callPackage ./pkgs/python3/pkgs/speechrecognition/speechrecognition.nix { };

      tpot = python3.pkgs.callPackage ./pkgs/python3/pkgs/tpot/tpot.nix {
        # FIXME scope
        update-checker = python3.pkgs.callPackage ./pkgs/python3/pkgs/update-checker/update-checker.nix { };
      };

      update-checker = python3.pkgs.callPackage ./pkgs/python3/pkgs/update-checker/update-checker.nix { };

      pydot-ng = python3.pkgs.callPackage ./pkgs/python3/pkgs/pydot-ng/pydot-ng.nix { };

      dcase-util = python3.pkgs.callPackage ./pkgs/python3/pkgs/dcase-util/dcase-util.nix {
        # FIXME scope
        pydot-ng = python3.pkgs.callPackage ./pkgs/python3/pkgs/pydot-ng/pydot-ng.nix { };
      };

      # nix-build . -A python3.pkgs.libarchive-c
      # https://github.com/NixOS/nixpkgs/pull/241606
      # python310Packages.libarchive-c: 4.0 -> 5.0
      libarchive-c = python3.pkgs.callPackage ./pkgs/python3/pkgs/libarchive-c/libarchive-c.nix {
        libarchive = callPackage ./pkgs/development/libraries/libarchive/libarchive.nix { };
      };

      # fix flask: ERROR: Could not find a version that satisfies the requirement blinker>=1.6.2
      # nix-init ./pkgs/python3/pkgs/blinker/blinker.nix --url https://github.com/pallets-eco/blinker
      blinker = python3.pkgs.callPackage ./pkgs/python3/pkgs/blinker/blinker.nix { };

      # fix flask: ERROR: Could not find a version that satisfies the requirement Werkzeug>=2.3.3
      # nix-init ./pkgs/python3/pkgs/werkzeug/werkzeug.nix --url https://github.com/pallets/werkzeug
      werkzeug = python3.pkgs.callPackage ./pkgs/python3/pkgs/werkzeug/werkzeug.nix { };

      flask-session2 = python3.pkgs.callPackage ./pkgs/python3/pkgs/flask-session2/flask-session2.nix { };

    });
  };

  deno = pkgs.deno // {
    pkgs = (pkgs.deno.pkgs or {}) // (
      callPackage ./pkgs/deno/pkgs { }
    );
  };

  caramel = callPackage ./pkgs/caramel/caramel.nix {
    # latest supported version is ocaml 4.11
    # https://github.com/AbstractMachinesLab/caramel/issues/105
    ocamlPackages = pkgs.ocaml-ng.ocamlPackages_4_11;
  };

  brother-hll6400dw = callPackage ./pkgs/misc/cups/drivers/brother/hll6400dw/hll6400dw.nix { };

  brother-hll5100dn = callPackage ./pkgs/misc/cups/drivers/brother/hll5100dn/hll5100dn.nix { };

  npmlock2nix = callPackage ./pkgs/development/tools/npmlock2nix/npmlock2nix.nix { };

  mvn2nix = callPackage ./pkgs/development/tools/mvn2nix/mvn2nix.nix { };

  # TODO
  #xi = callPackages ./pkgs/xi { };

  subdl = callPackage ./pkgs/applications/video/subdl/subdl.nix { };

  # TODO callPackages? seems to be no difference (singular vs plural)
  #inherit (callPackages ./pkgs/development/tools/parsing/antlr/4.nix { })
  inherit (callPackage ./pkgs/development/tools/parsing/antlr/4.nix { })
    antlr4_8
    antlr4_9
    antlr4_10
    antlr4_11
    antlr4_12
  ;

  antlr4 = antlr4_12;

  antlr = antlr4;

  turbobench = callPackage ./pkgs/tools/compression/turbobench/turbobench.nix { };

  kindle = kindle_1_23_50133;
  kindle_latest = kindle_1_40_65535;

  kindle_1_14_43029 = callPackage ./pkgs/applications/misc/kindle/kindle.nix { version = "1.14.43029"; };
  kindle_1_14_1_43029 = kindle_1_14_43029;
  kindle_1_14_1 = kindle_1_14_43029;

  kindle_1_15_43061 = callPackage ./pkgs/applications/misc/kindle/kindle.nix { version = "1.15.43061"; };
  kindle_1_15_0_43061 = kindle_1_15_43061;
  kindle_1_15_0 = kindle_1_15_43061;

  kindle_1_16_44025 = callPackage ./pkgs/applications/misc/kindle/kindle.nix { version = "1.16.44025"; };
  kindle_1_16_0_44025 = kindle_1_16_44025;
  kindle_1_16_0 = kindle_1_16_44025;

  kindle_1_17_44170 = callPackage ./pkgs/applications/misc/kindle/kindle.nix { version = "1.17.44170"; };
  kindle_1_17_0_44170 = kindle_1_17_44170;
  kindle_1_17_0 = kindle_1_17_44170;

  kindle_1_17_44183 = callPackage ./pkgs/applications/misc/kindle/kindle.nix { version = "1.17.44183"; };
  kindle_1_17_1_44183 = kindle_1_17_44183;
  kindle_1_17_1 = kindle_1_17_44183;

  kindle_1_20_47037 = callPackage ./pkgs/applications/misc/kindle/kindle.nix { version = "1.20.47037"; };
  kindle_1_20_1_47037 = kindle_1_20_47037;
  kindle_1_20_1 = kindle_1_20_47037;

  kindle_1_21_48017 = callPackage ./pkgs/applications/misc/kindle/kindle.nix { version = "1.21.48017"; };
  kindle_1_21_0_48017 = kindle_1_21_48017;
  kindle_1_21_0 = kindle_1_21_48017;

  kindle_1_23_50133 = callPackage ./pkgs/applications/misc/kindle/kindle.nix { version = "1.23.50133"; };
  kindle_1_23_1_50133 = kindle_1_23_50133;
  kindle_1_23_1 = kindle_1_23_50133;

  kindle_1_24_51068 = callPackage ./pkgs/applications/misc/kindle/kindle.nix { version = "1.24.51068"; };
  kindle_1_24_3_51068 = kindle_1_24_51068;
  kindle_1_24_3 = kindle_1_24_51068;

  kindle_1_25_52064 = callPackage ./pkgs/applications/misc/kindle/kindle.nix { version = "1.25.52064"; };
  kindle_1_25_1_52064 = kindle_1_25_52064;
  kindle_1_25_1 = kindle_1_25_52064;

  kindle_1_26_55076 = callPackage ./pkgs/applications/misc/kindle/kindle.nix { version = "1.26.55076"; };
  kindle_1_26_0_55076 = kindle_1_26_55076;
  kindle_1_26_0 = kindle_1_26_55076;

  kindle_1_28_57030 = callPackage ./pkgs/applications/misc/kindle/kindle.nix { version = "1.28.57030"; };
  kindle_1_28_0_57030 = kindle_1_28_57030;
  kindle_1_28_0 = kindle_1_28_57030;

  kindle_1_32_61109 = callPackage ./pkgs/applications/misc/kindle/kindle.nix { version = "1.32.61109"; };
  kindle_1_32_0_61109 = kindle_1_32_61109;
  kindle_1_32_0 = kindle_1_32_61109;

  kindle_1_34_63103 = callPackage ./pkgs/applications/misc/kindle/kindle.nix { version = "1.34.63103"; };
  kindle_1_34_1_63103 = kindle_1_34_63103;
  kindle_1_34_1 = kindle_1_34_63103;

  kindle_1_39_65323 = callPackage ./pkgs/applications/misc/kindle/kindle.nix { version = "1.39.65323"; };
  kindle_1_39_1_65323 = kindle_1_39_65323;
  kindle_1_39_1 = kindle_1_39_65323;

  kindle_1_39_65383 = callPackage ./pkgs/applications/misc/kindle/kindle.nix { version = "1.39.65383"; };
  kindle_1_39_2_65383 = kindle_1_39_65383;
  kindle_1_39_2 = kindle_1_39_65383;

  kindle_1_40_65415 = callPackage ./pkgs/applications/misc/kindle/kindle.nix { version = "1.40.65415"; };
  kindle_1_40_0_65415 = kindle_1_40_65415;
  kindle_1_40_0 = kindle_1_40_65415;

  kindle_1_40_65535 = callPackage ./pkgs/applications/misc/kindle/kindle.nix { version = "1.40.65535"; };
  kindle_1_40_1_65535 = kindle_1_40_65535;
  kindle_1_40_1 = kindle_1_40_65535;

  lzturbo = callPackage ./pkgs/tools/compression/lzturbo/lzturbo.nix { };

  netgear-telnetenable = callPackage ./pkgs/tools/networking/netgear-telnetenable/netgear-telnetenable.nix { };

  cmix = callPackage ./pkgs/tools/compression/cmix/cmix.nix { };

  # already in nixpkgs
  #kaitai-struct-compiler = callPackage ./pkgs/development/tools/parsing/kaitai-struct-compiler/kaitai-struct-compiler.nix { };

  ffsubsync = callPackage ./pkgs/applications/video/ffsubsync/ffsubsync.nix { };

  surge-filesharing = callPackage ./pkgs/applications/networking/p2p/surge-filesharing/surge-filesharing.nix { };

  tribler = callPackage ./pkgs/applications/networking/p2p/tribler/tribler.nix { };

  # pocketsphinx was removed in https://github.com/NixOS/nixpkgs/pull/170124
  # based on update in closed PR https://github.com/NixOS/nixpkgs/pull/169609

  # pkgs/development/libraries/pocketsphinx/default.nix
  # https://github.com/armeenm/nixpkgs/blob/5e826bad51e25f7b8e20e242964ec0e76e147f82/pkgs/development/libraries/pocketsphinx/default.nix
  pocketsphinx = callPackage ./pkgs/development/libraries/pocketsphinx/pocketsphinx.nix { };

  # https://github.com/cmusphinx/sphinxbase
  # SphinxBase has been integrated into PocketSphinx
  #sphinxbase = callPackage ./pkgs/development/libraries/sphinxbase/sphinxbase.nix { };

  mediawiki-scraper-2 = python3.pkgs.callPackage ./pkgs/tools/networking/mediawiki-scraper-2/mediawiki-scraper-2.nix { };

  mediawiki-scraper = python3.pkgs.callPackage ./pkgs/tools/networking/mediawiki-scraper/mediawiki-scraper.nix { };

  mediawiki-dump2html = callPackage ./pkgs/development/tools/mediawiki-dump2html/mediawiki-dump2html.nix { };

  mediawiki2html = python3.pkgs.callPackage ./pkgs/development/tools/mediawiki2html/mediawiki2html.nix { };

  pandoc-bin = pkgs.haskellPackages.callPackage ./pkgs/development/tools/pandoc-bin/pandoc-bin.nix { };

  mwdumper = callPackage ./pkgs/mwdumper/mwdumper.nix { };
  mediawiki-dumper = callPackage ./pkgs/mwdumper/mwdumper.nix { };

  pdfjam = callPackage ./pkgs/tools/typesetting/pdfjam/pdfjam.nix { };
  pdfjam-extras = callPackage ./pkgs/tools/typesetting/pdfjam/pdfjam-extras.nix { };

  curl-with-allow-dot-onion = (pkgs.curl.overrideAttrs (oldAttrs: {
    patches = (oldAttrs.patches or []) ++ [
      # add support for CURL_ALLOW_DOT_ONION=1
      # fix: I want to resolve onion addresses
      # https://github.com/curl/curl/discussions/11125
      (pkgs.fetchurl {
        url = "https://github.com/curl/curl/pull/11236.patch";
        sha256 = "sha256-Ma5pOVLTAz/bbdmo4s5QH3UFDlpVr7DZ9xSMcUy98B8=";
      })
    ];
  }));

  git-with-allow-dot-onion = (pkgs.git.override {
    curl = curl-with-allow-dot-onion;
  });

  radicle = callPackage ./pkgs/applications/version-management/radicle/radicle.nix { };

  radicle-httpd = radicle.overrideAttrs (oldAttrs: {
    pname = "radicle-httpd";
    buildAndTestSubdir = "radicle-httpd";
  });

  radicle-interface = callPackage ./pkgs/applications/version-management/radicle-interface/radicle-interface.nix { };

  radicle-bin = callPackage ./pkgs/applications/version-management/radicle/radicle-bin.nix { };

  cargo2nix = callPackage ./pkgs/development/tools/rust/cargo2nix/cargo2nix.nix { };

  unarr = callPackage ./pkgs/tools/archivers/unarr/unarr.nix { };

  # https://github.com/NixOS/nixpkgs/pull/244713
  # libarchive: 3.6.2 -> 3.7.0
  libarchive = callPackage ./pkgs/development/libraries/libarchive/libarchive.nix { };

}

# based on https://github.com/dtzWill/nur-packages
#// (callPackages ./pkgs/xi { })
)

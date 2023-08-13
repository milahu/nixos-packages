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

  archive-org-downloader = python3.pkgs.callPackage ./pkgs/archive-org-downloader/default.nix { };

  rpl = python3.pkgs.callPackage ./pkgs/rpl/default.nix { };

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

  gaupol = python3.pkgs.callPackage ./pkgs/gaupol/gaupol.nix { };

  autosub-by-abhirooptalasila = callPackage ./pkgs/autosub-by-abhirooptalasila/autosub.nix { };

  proftpd = callPackage ./pkgs/proftpd/proftpd.nix { };

  pyload = python3.pkgs.pyload;
  #pyload = python3Packages.pyload;

  rose = callPackage ./pkgs/rose/rose.nix { };

  tg-archive = python3.pkgs.callPackage ./pkgs/tg-archive/tg-archive.nix { };

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

  # alias: python3.pkgs -> python3Packages
  # no: error: attribute 'newScope' missing
  #python3 = pkgs.recurseIntoAttrs (lib.makeScope pkgs.python3.newScope (self: with self; ({
  #python3 = pkgs.recurseIntoAttrs ((({
  python3 = pkgs.recurseIntoAttrs (((pkgs.python3 // {
    pkgs = python3Packages;
  })));

  #python3 = pkgs.recurseIntoAttrs (((pkgs.python3 // {
  #python3 = pkgs.recurseIntoAttrs (lib.makeScope pkgs.newScope ((pkgs.python3 // {
  #python3 = pkgs.recurseIntoAttrs (lib.makeScope pkgs.python3.newScope ((pkgs.python3 // {
  #python3 = pkgs.recurseIntoAttrs (lib.makeScope pkgs.python3.newScope (self: with self; (pkgs.python3 // {
  #python3 = pkgs.recurseIntoAttrs (lib.makeScope pkgs.python3.newScope (self: with self; ({

    # fix: error: attribute 'sitePackages' missing: python3.sitePackages
    #sitePackages = "lib/python${pkgs.python3.pythonVersion}/site-packages";

    # FIXME scope with new callPackage
    #pkgs = (pkgs.python3.pkgs or {}) // ({
    # error: attribute 'buildPythonApplication' missing: python3.pkgs.buildPythonApplication
    #pkgs = (pkgs.python3.pkgs or {}) // lib.makeScope pkgs.newScope (self: with self; {
    # https://github.com/NixOS/nixpkgs/commit/632c4f2c9ba1f88cd5662da7bedf2ca5f0cda4a9 # add scope
    #pkgs = (lib.makeScope pkgs.newScope (self: with self; (pkgs.python3.pkgs or {}) // {
    #pkgs = (lib.makeScope pkgs.python3.pkgs.newScope (self: with self; (pkgs.python3.pkgs or {}) // {
    #pkgs = pkgs.recurseIntoAttrs (lib.makeScope pkgs.newScope (self: with self; (pkgs.python3.pkgs or {}) // {
    #pkgs = pkgs.recurseIntoAttrs (lib.makeScope pkgs.python3.pkgs.newScope (self: with self; (pkgs.python3.pkgs // {

  # TODO better?
  #python3Packages = pkgs.recurseIntoAttrs (lib.makeScope pkgs.python3Packages.newScope (self: with self; (pkgs.python3.pkgs // {
  #python3Packages = pkgs.recurseIntoAttrs (lib.makeScope pkgs.python3Packages.newScope (self: with self; ({
  python3Packages = pkgs.recurseIntoAttrs (pkgs.lib.makeScope pkgs.python3Packages.newScope (self: let inherit (self) callPackage; in ({
  #python3Packages = pkgs.recurseIntoAttrs (pkgs.lib.makeScope pkgs.python3Packages.newScope (self: let inherit (self) callPackage; in (pkgs.python3Packages // {

      # fix: error: attribute 'buildPythonPackage' missing: python3.pkgs.buildPythonPackage
      #python3 = pkgs.python3;
      python3 = pkgs.python3 // {
        # fix recursion
        #pkgs = self;
        # fix: error: undefined variable 'setuptools'
        pkgs = pkgs.python3.pkgs // self;
      };

      # fix: error: evaluation aborted with the following error message: 'Function called without required argument "buildPythonPackage" at /run/user/1000/tmp.Z1u4CqXj61-nur-eval-test/repo/pkgs/python3/pkgs/aalpy/aalpy.nix:2'
      buildPythonPackage = pkgs.python3.pkgs.buildPythonPackage;
      # fix: error: attribute 'buildPythonApplication' missing
      buildPythonApplication = pkgs.python3.pkgs.buildPythonApplication;

      # fix recursion
      #python3.pkgs = self;
      python3Packages = self;

      # fix: error: evaluation aborted with the following error message: 'Function called without required argument "buildPythonPackage" at /run/user/1000/tmp.Z1u4CqXj61-nur-eval-test/repo/pkgs/python3/pkgs/aalpy/aalpy.nix:2'
      # no:
      #callPackage = self.callPackage;

      # FIXME: error: evaluation aborted with the following error message: 'Function called without required argument "buildPythonPackage" at /run/user/1000/tmp.Z1u4CqXj61-nur-eval-test/repo/pkgs/python3/pkgs/aalpy/aalpy.nix:2'
      aalpy = callPackage ./pkgs/python3/pkgs/aalpy/aalpy.nix { };
      # ok:
      #aalpy = self.callPackage ./pkgs/python3/pkgs/aalpy/aalpy.nix { };

      auditok = callPackage ./pkgs/python3/pkgs/auditok/auditok.nix { };

      pysubs2 = callPackage ./pkgs/python3/pkgs/pysubs2/pysubs2.nix { };

      # TODO move
      #ffsubsync = callPackage ./pkgs/python3/pkgs/ffsubsync/ffsubsync.nix { };
      ffsubsync = callPackage ./pkgs/applications/video/ffsubsync/ffsubsync.nix { };

      ete3 = callPackage pkgs/python3/pkgs/ete3/ete3.nix { };

      faust-cchardet = callPackage ./pkgs/python3/pkgs/faust-cchardet/faust-cchardet.nix { };

      pocketsphinx = callPackage ./pkgs/python3/pkgs/pocketsphinx/pocketsphinx.nix {
        pkgs = pkgs // {
          # fix: error: pocketsphinx has been removed: unmaintained
          inherit pocketsphinx;
        };
      };

      speechrecognition = callPackage ./pkgs/python3/pkgs/speechrecognition/speechrecognition.nix { };

      tpot = callPackage ./pkgs/python3/pkgs/tpot/tpot.nix {
        # FIXME scope
        update-checker = callPackage ./pkgs/python3/pkgs/update-checker/update-checker.nix { };
      };

      update-checker = callPackage ./pkgs/python3/pkgs/update-checker/update-checker.nix { };

      pydot-ng = callPackage ./pkgs/python3/pkgs/pydot-ng/pydot-ng.nix { };

      dcase-util = callPackage ./pkgs/python3/pkgs/dcase-util/dcase-util.nix {
        # FIXME scope
        pydot-ng = callPackage ./pkgs/python3/pkgs/pydot-ng/pydot-ng.nix { };
      };

      # nix-build . -A python3.pkgs.libarchive-c
      # https://github.com/NixOS/nixpkgs/pull/241606
      # python310Packages.libarchive-c: 4.0 -> 5.0
      libarchive-c = callPackage ./pkgs/python3/pkgs/libarchive-c/libarchive-c.nix {
        libarchive = callPackage ./pkgs/development/libraries/libarchive/libarchive.nix { };
      };

      # fix flask: ERROR: Could not find a version that satisfies the requirement blinker>=1.6.2
      # nix-init ./pkgs/python3/pkgs/blinker/blinker.nix --url https://github.com/pallets-eco/blinker
      blinker = callPackage ./pkgs/python3/pkgs/blinker/blinker.nix { };

      # fix flask: ERROR: Could not find a version that satisfies the requirement Werkzeug>=2.3.3
      # nix-init ./pkgs/python3/pkgs/werkzeug/werkzeug.nix --url https://github.com/pallets/werkzeug
      werkzeug = callPackage ./pkgs/python3/pkgs/werkzeug/werkzeug.nix { };

      # https://github.com/NixOS/nixpkgs/pull/245320
      # python3Packages.flask: 2.2.5 -> 2.3.2
      # nix-init pkgs/python3/pkgs/flask/flask.nix --url https://github.com/pallets/flask
      # FIXME use python3.pkgs.werkzeug from this scope
      #flask = callPackage ./pkgs/python3/pkgs/flask/flask.nix { };
      flask = self.callPackage ./pkgs/python3/pkgs/flask/flask.nix { };

      # nix-init pkgs/python3/pkgs/flask-caching/flask-caching.nix --url https://github.com/pallets-eco/flask-caching
      # FIXME: ERROR: Could not find a version that satisfies the requirement Flask<3 (from flask-caching) (from versions: none)
      # update?
      flask-caching = callPackage ./pkgs/python3/pkgs/flask-caching/flask-caching.nix { };

      # no: nix-init pkgs/python3/pkgs/flask-compress/flask-compress.nix --url https://github.com/colour-science/flask-compress
      # fix: LookupError: setuptools-scm was unable to detect version for /build/source.
      # Make sure you're either building from a fully intact git repository or PyPI tarballs. Most other sources (such as GitHub's tarballs, a git checkout without the .git folder) don't contain the necessary metadata and will not work.
      # nix-init pkgs/python3/pkgs/flask-compress/flask-compress.nix --url https://pypi.org/project/flask-compress
      flask-compress = callPackage ./pkgs/python3/pkgs/flask-compress/flask-compress.nix { };

      # nix-init pkgs/python3/pkgs/flask-session/flask-session.nix --url https://github.com/pallets-eco/flask-session
      flask-session = callPackage ./pkgs/python3/pkgs/flask-session/flask-session.nix { };

      # nix-init pkgs/python3/pkgs/flask-babel/flask-babel.nix --url https://github.com/python-babel/flask-babel
      flask-babel = callPackage ./pkgs/python3/pkgs/flask-babel/flask-babel.nix { };

      # nix-init pkgs/python3/pkgs/flask-session2/flask-session2.nix --url https://github.com/christopherpickering/flask-session2
      flask-session2 = callPackage ./pkgs/python3/pkgs/flask-session2/flask-session2.nix { };

      # no: nix-init pkgs/python3/pkgs/flask-themes2/flask-themes2.nix --url https://github.com/sysr-q/flask-themes2
      # update version: 0.1.3 -> 1.0.0
      # https://github.com/sysr-q/flask-themes2/issues/13 # add git tags for pypi versions
      # nix-init pkgs/python3/pkgs/flask-themes2/flask-themes2.nix --url https://pypi.org/project/Flask-Themes2/
      flask-themes2 = callPackage ./pkgs/python3/pkgs/flask-themes2/flask-themes2.nix { };

      pyjsparser = callPackage ./pkgs/python3/pkgs/pyjsparser/pyjsparser.nix { };

      js2py = callPackage ./pkgs/python3/pkgs/js2py/js2py.nix { };

      # python3.pkgs.pyload
      #pyload = callPackage ./pkgs/python3/pkgs/pyload/pyload.nix { };
      pyload = python3.pkgs.callPackage ./pkgs/python3/pkgs/pyload/pyload.nix { };

      git-filter-repo = callPackage ./pkgs/development/python-modules/git-filter-repo/git-filter-repo.nix { };

    #}))); # python3.pkgs

  #}))); # python3

  }))); # python3Packages

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

  nix-gitignore = callPackage ./pkgs/build-support/nix-gitignore/nix-gitignore.nix { };

  # mvn2nix
  inherit (callPackage ./pkgs/development/tools/mvn2nix/mvn2nix.nix { })
    mvn2nix
    mvn2nix-bootstrap
    buildMavenRepository
    buildMavenRepositoryFromLockFile
  ;

  # TODO
  #xi = callPackages ./pkgs/xi { };

  subdl = python3.pkgs.callPackage ./pkgs/applications/video/subdl/subdl.nix { };

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

  netgear-telnetenable = python3.pkgs.callPackage ./pkgs/tools/networking/netgear-telnetenable/netgear-telnetenable.nix { };

  cmix = callPackage ./pkgs/tools/compression/cmix/cmix.nix { };

  # already in nixpkgs
  #kaitai-struct-compiler = callPackage ./pkgs/development/tools/parsing/kaitai-struct-compiler/kaitai-struct-compiler.nix { };

  ffsubsync = python3.pkgs.ffsubsync;

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

  git-filter-repo = python3.pkgs.git-filter-repo;

  # nix-init ./pkgs/applications/audio/tap-bpm-cli/tap-bpm-cli.nix --url https://github.com/marakoss/tap-bpm-cli
  tap-bpm-cli = callPackage ./pkgs/applications/audio/tap-bpm-cli/tap-bpm-cli.nix { };

  # https://github.com/NixOS/nixpkgs/pull/158152 # gh2md: init at 2.0.0
  # https://github.com/NixOS/nixpkgs/blob/master/pkgs/tools/backup/gh2md/default.nix
  gh2md = callPackage ./pkgs/tools/backup/gh2md/gh2md.nix { };

  nodejs-hide-symlinks = callPackage ./pkgs/development/web/nodejs-hide-symlinks/nodejs-hide-symlinks.nix { };

  nodePackages = pkgs.recurseIntoAttrs (pkgs.lib.makeScope pkgs.newScope (self: let inherit (self) callPackage; in ({

    cowsay = callPackage ./pkgs/node/pkgs/cowsay/cowsay.nix { };

    npmlock2nix = callPackage ./pkgs/development/tools/npmlock2nix/npmlock2nix.nix { };

    pnpm-install-only = callPackage ./pkgs/node/pkgs/pnpm-install-only/pnpm-install-only.nix {
      # bootstrap npmlock2nix without pnpm-install-only
      npmlock2nix = callPackage ./pkgs/development/tools/npmlock2nix/npmlock2nix.nix {
        pnpm-install-only = null;
      };
    };

  })));

}

# based on https://github.com/dtzWill/nur-packages
#// (callPackages ./pkgs/xi { })
)

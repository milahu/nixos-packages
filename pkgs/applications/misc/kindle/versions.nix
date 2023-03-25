/*

sources:

  https://community.chocolatey.org/packages/Kindle#versionhistory
  https://archive.org/search?query=title%3A%28kindle+for+pc%29
  https://archive.org/search?query=title%3AKindleForPC
  https://www.mobileread.com/forums/showthread.php?t=283371
  https://github.com/search?q=kindleforpc-installer&ref=opensearch&type=code
  https://github.com/vace117/calibre-dedrm-docker-image/tree/master/resources/windows

version example:

  1.17.44170 = source version, as in filename KindleForPC-installer-1.17.44170.exe
  1.17.0.44170 = full version, as shown by "7z x *.exe"
  1.17.0 = short version

im using the "source version" because it is the most visible version in the build process

im using base16 sha256 hashes, because most websites use this format

*/

rec {

  # Kindle.1.0.0.0.nupkg

  # Kindle.1.11.2.nupkg

  # KindleForPC-installer-1.12.40996.exe
  # http://kindleforpc.amazon.com/40996/KindleForPC-installer-1.12.40996.exe

  # http://kindleforpc.amazon.com/43019/KindleForPC-installer-1.14.43019.exe
  # d92901bb2d62535922017bbd0f2b2378

  # Kindle.1.15.43061.nupkg
  # https://s3.amazonaws.com/kindleforpc/43061/KindleForPC-installer-1.15.43061.exe
  # a40840ae89a771892732e96685c22096
  "1.15.43061" = {
    src = builtins.fetchurl {
      # https://archive.org/details/kindleforpc-installer-1.15.43061_202102
      name = "KindleForPC-installer-1.15.43061.exe";
      url = "https://archive.org/download/kindleforpc-installer-1.15.43061_202102/kindleforpc-installer-1.15.43061.exe";
      sha256 = "sha256:b854006aeb02b80ce9410c360a813c422b21daece6e24286a4746d802cfc981f";
    };
  };

  /*
  https://github.com/arnavbhatt288/rapps-db/blob/375e5e8eb8ad062a19fe15b18e6d7a506441bcf0/kindlepc.txt#L8
  URLSite = www.amazon.com/kindleforpc
  URLDownload = http://kindleforpc.amazon.com/44025/KindleForPC-installer-1.16.44025.exe
  SHA1 = c57d0a7d8cd5f1c3020536edf336c3187f3e051f
  SizeBytes = 65292192
  */

  # runtime error: unable to connect
  #"1.17.0" = "1.17.44170";
  #"1.17.0.44170" = "1.17.44170";
  # https://github.com/apprenticeharper/DeDRM_tools/blob/master/FAQs.md
  "1.17.44170" = {
    src = builtins.fetchurl {
      # https://archive.org/details/kindle-for-pc-1-17-44170
      name = "KindleForPC-installer-1.17.44170.exe";
      url = "https://archive.org/download/kindle-for-pc-1-17-44170/kindle-for-pc-1-17-44170.exe";
      sha256 = "sha256:14e0f0053f1276c0c7c446892dc170344f707fbfe99b6951762c120144163200";
    };
  };

  /*
  # https://github.com/apprenticeharper/DeDRM_tools/blob/master/FAQs.md
  #### Kindle for Mac `KindleForMac-44182.dmg`:
  * MD-5: E7E36D5369E1F3CF1D28E5D9115DF15F
  * SHA-1: 7AB9A86B954CB23D622BD79E3257F8E2182D791C
  * SHA-256: 28DC21246A9C7CDEDD2D6F0F4082E6BF7EF9DB9CE9D485548E8A9E1D19EAE2AC
  */

  # runtime error: unable to connect
  #"1.17.1" = "1.17.44183";
  #"1.17.1.44183" = "1.17.44183";
  # https://github.com/BenAAndrew/Voice-Cloning-App/blob/main/docs/dataset.md
  "1.17.44183" = {
    src = builtins.fetchurl {
      # https://archive.org/details/kindle-for-pc-installer-1.17.44183
      url = "https://archive.org/download/kindle-for-pc-installer-1.17.44183/KindleForPC-installer-1.17.44183.exe";
      sha256 = "sha256:c3861198d6a18bf1eef6f6970705f7f57b5ff152b733abbadaadd4d1bff4be17";
    };
  };

  # Kindle.1.20.nupkg
  #-Url 'https://s3.amazonaws.com/kindleforpc/47037/KindleForPC-installer-1.20.47037.exe' `
  #-Checksum 'CB20581D3455D458C7AC4BAFA5C67DCFC5186C7B35951168EFCF5A8263706B47' `

  # runtime error: deadloop
  # output is crazy verbose. workaround: kindle >/dev/null
  #"1.21.0" = "1.21.48017";
  "1.21.48017" = {
    src = builtins.fetchurl {
      # https://archive.org/details/kindle-for-pc-installer-1.21.48017
      url = "https://archive.org/download/kindle-for-pc-installer-1.21.48017/KindleForPC-installer-1.21.48017.exe";
      sha256 = "sha256:a6ea9068fabcdfde6da3099fa242c19bede3e393f2c6d3cb24c859a5f4281ae7";
    };
  };

  # Kindle.1.23.50133.nupkg
  #-Url 'https://s3.amazonaws.com/kindleforpc/50133/KindleForPC-installer-1.23.50133.exe' `
  #-Checksum 'B66F5F4F8A68965A6D04AA41C97816A043517A24E19CFF943B804F1A1363CF08' `

  # Kindle.1.24.51068.nupkg
  #-Url 'https://s3.amazonaws.com/kindleforpc/51068/KindleForPC-installer-1.24.51068.exe' `
  #-Checksum 'C7A1A93763D102BCA0FED9C16799789AE18C3322B1B3BDFBE8C00422C32F83D7' `

  # Kindle.1.25.52064.nupkg
  #-Url 'https://s3.amazonaws.com/kindleforpc/52064/KindleForPC-installer-1.25.52064.exe' `
  #-Checksum '314678A0A3B867BF412936ADAA67C6AB6D41C961F359A46F99C3AFA591702EF7' `
  # https://github.com/JPinkney/winget-pkgs/blob/628f87aefcee8df1c54ab7866e0686f8182549fc/manifests/Amazon/Kindle/1.25.52064.yaml#L16

  # runtime error: crashes on start
  #"1.28.0" = "1.28.57030";
  #"1.28.0.57030" = "1.28.57030";
  "1.28.57030" = {
    src = builtins.fetchurl {
      # https://archive.org/details/kindle-for-pc-installer-1.28.57030
      url = "https://archive.org/download/kindle-for-pc-installer-1.28.57030/KindleForPC-installer-1.28.57030.exe";
      sha256 = "sha256:6feea6ec44ff3d3b7be23e7a969fe14ab884a7b19e23bc2c74237730411559f6";
    };
  };

  # Kindle.1.29.58059.nupkg
  #url           = 'https://s3.amazonaws.com/kindleforpc/58059/KindleForPC-installer-1.29.58059.exe'
  #checksum      = '09b4d9cab09b7d59384ac83436d0cbe22e6514ec373e02b315ad9a3ed6047d5e'

  # Kindle.1.30.59056.nupkg
  #url           = 'https://s3.amazonaws.com/kindleforpc/59056/KindleForPC-installer-1.30.59056.exe'
  #checksum      = 'f4484348e60395386096ee1d75c7b3e73b43cd7b2a8d37d07ff89ddb43b26733'

  # Kindle.1.31.60170.nupkg
  #url           = 'https://s3.amazonaws.com/kindleforpc/60170/KindleForPC-installer-1.31.60170.exe'
  #checksum      = '3c5eaace1a3db0e67231791181b24174fa2978b2b37ff6a25d238299c1cb29da'
  # https://github.com/derrickstolee/winget-pkgs/blob/bc326a444af91e5266686ecc046726db5f2a06d9/manifests/a/Amazon/Kindle/1.31.60170/Amazon.Kindle.yaml#L23

  # runtime error: terminate called after throwing an instance of 'dxvk::DxvkError'
  #"1.32.0"
  "1.32.61109" = {
    src = builtins.fetchurl {
      # https://archive.org/details/kindle-for-pc-1-32-61109
      name = "KindleForPC-installer-1.32.61109.exe";
      url = "https://archive.org/download/kindle-for-pc-1-32-61109/kindle-for-pc-1-32-61109.exe";
      sha256 = "sha256:1d027c1b73163d4d3c7ce0c731b6c1daeb4ba27accedd3578c798dad20c73c78";
    };
  };

  # Kindle.1.33.62002.nupkg
  #url           = 'https://kindleforpc.s3.amazonaws.com/62002/KindleForPC-installer-1.33.62002.exe'
  #checksum      = '6f5616d9ccf8b76ce394a71ef5313aacfa833ade4e3cfcb2a61b35193d2d6b38'

  # runtime error: terminate called after throwing an instance of 'dxvk::DxvkError'
  #"1.34.1"
  #"1.34.1.63103"
  "1.34.63103" = {
    src = builtins.fetchurl {
      # https://archive.org/details/kindle-for-pc-installer-1.34.63103
      url = "https://archive.org/download/kindle-for-pc-installer-1.34.63103/KindleForPC-installer-1.34.63103.exe";
      sha256 = "sha256:3dc62b3895954fc171d4a3d08f2b7a1a503233e373c163adb7bc7fd34cdeff49";
    };
  };

  # Kindle.1.35.64251.nupkg
  #url           = 'https://kindleforpc.s3.amazonaws.com/64251/KindleForPC-installer-1.35.64251.exe'
  #checksum      = '48828d9cff9cc07d8725c9c20d4894fb50e0fc83e0391757bc552c403e4c436a'

  # Kindle.1.36.65107.nupkg
  #url           = 'https://kindleforpc.s3.amazonaws.com/65107/KindleForPC-installer-1.36.65107.exe'
  #checksum      = '1c3879dda9b11f96e7232896e6fab0168c7536fd966594f1f4072df536bd0fd5'

  # Kindle.1.37.65274.nupkg
  #url           = 'https://kindleforpc.s3.amazonaws.com/65274/KindleForPC-installer-1.37.65274.exe'
  #checksum      = '11f6501142960337f7106ce6acfe9ec26d6d3289c5190b3f154272b2517de760'

  # Kindle.1.38.65290.nupkg
  #url           = 'https://kindleforpc.s3.amazonaws.com/65290/KindleForPC-installer-1.38.65290.exe'
  #checksum      = '44f04a311b99e0d7f0bf04b7a01699993e49a2ebac6364ef91798482f1a3e8f8'
  # https://forum.winehq.org/viewtopic.php?t=36985
  # mkdir -p $WINEPREFIX/drive_c/users/$USER/AppData/Local/Amazon/Kindle/crashdump
  # https://github.com/emmanuelrosa/erosanix/blob/491f24b47ed8bcbfeb0011374fd8829fa45438c5/pkgs/amazon-kindle/default.nix#L40
  # mkdir -p "$WINEPREFIX/drive_c/users/$USER/AppData/Local/Amazon/Kindle/crashdump"

  # Kindle.1.39.65306.nupkg
  #url           = 'https://kindleforpc.s3.amazonaws.com/65306/KindleForPC-installer-1.39.65306.exe'
  #checksum      = 'c1e53345295902e944850b1aa8d9ffa751bcbbf422aa4a096d4d934b5e9916cb'

  # Kindle.1.39.65323.nupkg
  #url           = 'https://kindleforpc.s3.amazonaws.com/65323/KindleForPC-installer-1.39.65323.exe'
  #checksum      = '30363931fe21070d95dc846695759e370f9961391b15a94460c641844650f0f6'
  # https://github.com/emmanuelrosa/erosanix/blob/master/pkgs/amazon-kindle/default.nix

  # Kindle.1.39.65383.nupkg
  #url           = 'https://kindleforpc.s3.amazonaws.com/65383/KindleForPC-installer-1.39.65383.exe'
  #checksum      = '8190f52ea85a01f35b3f7d0280321497b53bd74c8b8fa68111c48b093f3c0c7f'

  # Kindle.1.40.65415.nupkg
  #url           = 'https://kindleforpc.s3.amazonaws.com/65415/KindleForPC-installer-1.40.65415.exe'
  #checksum      = '67e31b8e45b9a537ad3ff64c65cbcb5de4e5b5569c28922daf5ba29983d87bc2'

  # Kindle.1.40.65535.nupkg
  #url           = 'https://kindleforpc.s3.amazonaws.com/65535/KindleForPC-installer-1.40.65535.exe'
  #checksum      = '03d4ca7a54ea01b1c0405e26e31008ef70ee19c1b13957badb661898528f724b'

}

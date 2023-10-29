{ lib
, stdenvNoCC
, fetchurl
}:
stdenvNoCC.mkDerivation rec {
  pname = "zpix-pixel-font";
  version = "3.1.8";

  srcs = [
    (fetchurl {
      name = "zpix-pixel-font.bdf";
      url = "https://github.com/SolidZORO/zpix-pixel-font/releases/download/v${version}/zpix.bdf";
      hash = "sha256-qE6YPKuk1FRRrTvmy4YIDuxRfslma264piUDj1FWtk4=";
    })
    (fetchurl {
      name = "zpix-pixel-font.ttf";
      url = "https://github.com/SolidZORO/zpix-pixel-font/releases/download/v${version}/zpix.ttf";
      hash = "sha256-UIgLGsVTbyhYMKfTYiA+MZmV4dFT9HX3sxTdrcc4vE0=";
    })
  ];

  dontUnpack = true;

  installPhase = ''
    runHook preInstall
    install -Dm444 $srcs/*.bdf $out/share/fonts/misc/zpix.bdf
    install -Dm444 $srcs*.ttf $out/share/fonts/truetype/zpix.ttf
    runHook postInstall
  '';

  meta = with lib; {
    description = "A pixel font supporting multiple languages like English, Chinese and Japanese.";
    homepage = "https://github.com/SolidZORO/zpix-pixel-font/";
    changelog = "https://github.com/SolidZORO/zpix-pixel-font/blob/master/CHANGELOG.md";
    license = licenses.unfreeRedistributable;
    maintainers = [ maintainers.adriangl ];
    platforms = platforms.all;
  };
}
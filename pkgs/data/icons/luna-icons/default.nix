{ lib
, stdenv
, fetchFromGitHub
, gtk3
, breeze-icons
, hicolor-icon-theme
, pantheon
}:

stdenv.mkDerivation rec {
  pname = "luna-icons";
  version = "1.8";

  src = fetchFromGitHub {
    owner = "darkomarko42";
    repo = pname;
    rev = version;
    sha256 = "1c317ac43ff70sxn1syx20qhs4nkccv6hbf69fmi3acswqsll1z4";
  };

  nativeBuildInputs = [
    gtk3
  ];

  propagatedBuildInputs = [
    breeze-icons
    hicolor-icon-theme
    pantheon.elementary-icon-theme
  ];

  dontDropIconThemeCache = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/icons
    cp -a Luna* $out/share/icons

    for theme in $out/share/icons/*; do
      gtk-update-icon-cache "$theme"
    done

    runHook postInstall
  '';

  meta = with lib; {
    description = "Icon pack based on marwaita and papirus icons";
    homepage = "https://github.com/darkomarko42/Luna-Icons";
    license = [ licenses.gpl3Only ];
    platforms = platforms.linux;
    maintainers = with maintainers; [ romildo ];
  };
}

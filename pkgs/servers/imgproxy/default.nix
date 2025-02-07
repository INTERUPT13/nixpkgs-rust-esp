{ lib, buildGoModule, fetchFromGitHub, pkg-config, vips, gobject-introspection
, stdenv, libunwind }:

buildGoModule rec {
  pname = "imgproxy";
  version = "3.1.3";

  src = fetchFromGitHub {
    owner = pname;
    repo = pname;
    sha256 = "sha256-aQ+EKUsqmsdCvEeKNNoF2Sj5+BN8yuhJAbL4BnYWINM=";
    rev = "v${version}";
  };

  vendorSha256 = "sha256-MHcV6n6uZsjC85vQVl+o6JD+psvE2xuPr//3RueT8V0=";

  doCheck = false;

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ gobject-introspection vips ]
    ++ lib.optionals stdenv.isDarwin [ libunwind ];

  preBuild = ''
    export CGO_LDFLAGS_ALLOW='-(s|w)'
  '';

  meta = with lib; {
    description = "Fast and secure on-the-fly image processing server written in Go";
    homepage = "https://imgproxy.net";
    license = licenses.mit;
    maintainers = with maintainers; [ paluh ];
  };
}

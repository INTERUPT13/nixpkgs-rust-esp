{ lib, stdenv, fetchFromGitHub, opencl-headers, cmake, withTracing ? false }:

stdenv.mkDerivation rec {
  name = "khronos-ocl-icd-loader-${version}";
  version = "2021.06.30";

  src = fetchFromGitHub {
    owner = "KhronosGroup";
    repo = "OpenCL-ICD-Loader";
    rev = "v${version}";
    sha256 = "sha256-1bSeGI8IufKtdcyxVHX4DVxkPKfJrUBVzzIGe8rQ/AA=";
  };

  patches = lib.optional withTracing ./tracing.patch;

  nativeBuildInputs = [ cmake ];
  buildInputs = [ opencl-headers ];

  meta = with lib; {
    description = "Offical Khronos OpenCL ICD Loader";
    homepage = "https://github.com/KhronosGroup/OpenCL-ICD-Loader";
    license = licenses.asl20;
    platforms = platforms.linux;
    maintainers = with maintainers; [ davidtwco ];
  };
}

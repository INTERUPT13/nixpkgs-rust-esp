{ buildPythonPackage
, lib
, fetchFromGitHub
, pythonOlder
, cookiecutter
, filelock
, huggingface-hub
, importlib-metadata
, regex
, requests
, numpy
, packaging
, protobuf
, pyyaml
, sacremoses
, tokenizers
, tqdm
}:

buildPythonPackage rec {
  pname = "transformers";
  version = "4.12.5";

  src = fetchFromGitHub {
    owner = "huggingface";
    repo = pname;
    rev = "v${version}";
    sha256 = "07v72fyhm1s3bzg2kvaff15d7d8na39nlqpf5gyxaqvp3hglc3qy";
  };

  nativeBuildInputs = [ packaging ];

  propagatedBuildInputs = [
    cookiecutter
    filelock
    huggingface-hub
    numpy
    protobuf
    pyyaml
    regex
    requests
    sacremoses
    tokenizers
    tqdm
  ] ++ lib.optionals (pythonOlder "3.8") [ importlib-metadata ];

  # Many tests require internet access.
  doCheck = false;

  postPatch = ''
    sed -ri 's/tokenizers[=>]=[^"]+/tokenizers/g' setup.py src/transformers/dependency_versions_table.py
  '';

  pythonImportsCheck = [ "transformers" ];

  meta = with lib; {
    homepage = "https://github.com/huggingface/transformers";
    description = "State-of-the-art Natural Language Processing for TensorFlow 2.0 and PyTorch";
    changelog = "https://github.com/huggingface/transformers/releases/tag/v${version}";
    license = licenses.asl20;
    platforms = platforms.unix;
    maintainers = with maintainers; [ pashashocky ];
  };
}

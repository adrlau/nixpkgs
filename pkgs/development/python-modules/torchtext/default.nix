{ lib
, buildPythonPackage
, fetchFromGitHub
, cmake
, ninja
, python
, pythonPackages
, git
, numactl
, pythonBuild
, pythonInstaller
, pythonSetuptools
, pythonSympy
, pythonWheel
}:

buildPythonPackage rec {
  pname = "torchtext";
  version = "0.15.2";

  src = fetchFromGitHub {
    owner = "pytorch";
    repo = "text";
    rev = "v${version}";
    sha256 = "";
  };

  nativeBuildInputs = [
    cmake
    git
    ninja
    numactl
    pythonBuild
    pythonInstaller
    pythonSetuptools
    pythonSympy
    pythonWheel
  ];

  propagatedBuildInputs = [
    pythonPackages.numpy
    pythonPackages.pytorch
    pythonPackages.requests
    pythonPackages.tqdm
    pythonPackages.spacy
  ];

  checkInputs = [
    pythonPackages.nose
  ];

  postUnpack = ''
    cd $sourceRoot
    git submodule update --init --recursive
  '';

  buildPhase = ''
    python -m build --wheel --no-isolation
  '';

  installPhase = ''
    python -m installer --destdir="$out" dist/*.whl
    install -Dm644 LICENSE -t "$out/usr/share/licenses/${pname}"
  '';

  meta = with lib; {
    description = "Data loaders and abstractions for text and NLP";
    homepage = "https://github.com/pytorch/text";
    license = licenses.bsd3;
    platforms = platforms.unix;
  };
}
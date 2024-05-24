{ lib
, buildPythonPackage
, fetchFromGitHub
, setuptools
, wheel
}:

buildPythonPackage rec {
  pname = "whisper-live";
  version = "0.4.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "collabora";
    repo = "WhisperLive";
    rev = "v${version}";
    hash = "sha256-rI4sIRYK9eY9397H+P3rsV/mHM97ipZhcEzD9t9H3hM=";
  };

  nativeBuildInputs = [
    setuptools
    wheel
  ];

  pythonImportsCheck = [ "whisper_live" ];

  meta = with lib; {
    description = "A nearly-live implementation of OpenAI's Whisper";
    homepage = "https://github.com/collabora/WhisperLive/archive/refs/tags/v0.4.1.tar.gz";
    license = licenses.mit;
    maintainers = with maintainers; [ 
      adriangl
    ];
  };
}

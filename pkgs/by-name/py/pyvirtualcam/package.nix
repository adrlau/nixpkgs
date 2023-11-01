{ lib, fetchFromGitHub, python3Packages }:

python3Packages.buildPythonApplication rec {
  pname = "pyvirtualcam";
  version = "0.10.2";
  format = "pyproject";

  disabled = python3Packages.pythonOlder "3.10";

  src = fetchFromGitHub {
    owner = "letmaik";
    repo = "pyvirtualcam";
    rev = version;
    hash = "sha256-x/Rar80jwBX64pW+uv0edhlC44OP1b1e2vnJLFGlIms=";
  };

  nativeBuildInputs = with python3Packages; [ imageio opencv ];

  postInstall = ''
    # file has shebang but cant be run due to a relative import, has proper entrypoint in /bin
    chmod -x $out/${python3Packages.python.sitePackages}/pyprland/command.py
  '';

  pythonImportsCheck = [

  ];

  meta = with lib; {
    mainProgram = "";
    description = "An virtual camera library for python";
    homepage = "https://github.com/letmaik/pyvirtualcam";
    license = licenses.mit;
    maintainers = with maintainers; [ adriangl ];
    platforms = platforms.linux;
  };
}

{ lib, fetchurl, stdenvNoCC, buildPythonPackage, typing-extensions }:

let
  version = "17.2.12";
  format = "wheel";
  wheelUrl = "https://files.pythonhosted.org/packages/82/ce/15c3d81df3c69ec384216026bf2df0018912deb15fed23d6fa69d85a4015/frida-17.2.12-cp37-abi3-manylinux_2_5_x86_64.whl";
  # Replace with the sha256 of your wheel (obtained by running `nix-prefetch-url --unpack <url>`)
  hash = "sha256-4qjytqWSY/BzU+ncPQsMHd9foCEK/dTtg6z9k6yGosE=";
in
buildPythonPackage {
  pname = "frida-python";
  inherit version format;

 propagatedBuildInputs = [ typing-extensions ];  

  src = fetchurl {
    url = wheelUrl;
    sha256 = hash;
  };

  pythonImportsCheck = [
    "frida"
    "frida._frida"
  ];

  meta = {
    description = "Dynamic instrumentation toolkit for developers, reverse-engineers, and security researchers (Python bindings)";
    homepage = "https://www.frida.re";
    license = lib.licenses.wxWindows;
    maintainers = with lib.maintainers; [ s1341 ];
    platforms = [ "x86_64-windows" "aarch64-windows" ];
  };
}


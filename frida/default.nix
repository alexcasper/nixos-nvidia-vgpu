{ lib, fetchurl, stdenvNoCC, buildPythonPackage }:

let
  version = "17.2.12";
  format = "wheel";
  wheelUrl = "https://files.pythonhosted.org/packages/ed/2d/2bcf5f9d61beba9d4134e1c8a1aa0944bebfd2dc8fe525eb3ed6afd8bc78/frida-17.2.12-cp37-abi3-win_arm64.whl";
  # Replace with the sha256 of your wheel (obtained by running `nix-prefetch-url --unpack <url>`)
  hash = "sha256-C2ocY2NzsvMMQi8Uo2nZ4CnMSwfSuZGK36j41rnz5sA=";
in
buildPythonPackage {
  pname = "frida-python";
  inherit version format;

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


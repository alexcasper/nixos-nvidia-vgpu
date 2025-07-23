{ lib, fetchurl, stdenvNoCC, buildPythonPackage }:

let
  version = "17.2.12";
  format = "wheel";
  wheelUrl = "https://files.pythonhosted.org/packages/19/8c/00f61c8a5169d51ae3dd740cc63eaa44c4dfe857acbc7389ed72d8f697f6/frida-17.2.12-cp37-abi3-win_amd64.whl";
  # Replace with the sha256 of your wheel (obtained by running `nix-prefetch-url --unpack <url>`)
  hash = "sha256-CBoAFgOM6IxJGm239gzmUHC1W3/p3AKRRpACucSm/MA=";
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


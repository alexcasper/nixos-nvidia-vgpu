# updated as per https://github.com/NixOS/nixpkgs/tree/fe51d34885f7b5e3e7b59572796e1bcb427eccb1/pkgs/development/python-modules/frida-python

{
  lib,
  fetchPypi,
  stdenvNoCC,
  buildPythonPackage,
}:
let
  version = "17.2.12";
  format = "wheel";
  inherit (stdenvNoCC.hostPlatform) system;

  # https://pypi.org/project/frida/#files
  pypiMeta =
    {
      x86_64-linux = {
        hash = "sha256-ce419d852546c5cd7f54544191d5ed61b8435e971a95b4f348f4d79f8362faa9";
        platform = "manylinux1_x86_64";
      };
      aarch64-linux = {
        hash = "sha256-289509cc11cd78ed594d8eb2d5afb4aa9a68edba6df13748ff3b954875c172c4";
        platform = "manylinux2014_aarch64";
      };
      x86_64-darwin = {
        hash = "sha256-7ec46739bbe528d2a6c114e75f6cb5ffea126fc455508e0e9e7def564c7e45f5";
        platform = "macosx_10_13_x86_64";
      };
      aarch64-darwin = {
        hash = "sha256-d0a0fc91195b63f6204cfd1ebe375dcc53440bc7316acdf435e6c5150ecfef48";
        platform = "macosx_11_0_arm64";
      };
    }
    .${system} or (throw "Unsupported system: ${system}");
in
buildPythonPackage {
  pname = "frida-python";
  inherit version format;

  src = fetchPypi {
    pname = "frida";
    inherit version format;
    inherit (pypiMeta) hash platform;
    abi = "abi3";
    python = "cp37";
    dist = "cp37";
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
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
  };
}

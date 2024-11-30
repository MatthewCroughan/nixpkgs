{ python3Packages
, makeBinaryWrapper
}:

python3Packages.toPythonApplication (python3Packages.private-gpt.overrideAttrs (oldAttrs: {
  nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ makeBinaryWrapper ];

  passthru = (oldAttrs.passthru or {}) // {
    cl100k_base = {
      inherit (python3Packages.private-gpt.cl100k_base) tiktoken;
    };
  };

  postInstall = oldAttrs.postInstall + ''
    makeWrapper ${python3Packages.python.interpreter} $out/bin/private-gpt \
      --prefix PYTHONPATH : "$PYTHONPATH" \
      --set-default PGPT_SETTINGS_FOLDER "$out/${python3Packages.python.sitePackages}/private_gpt" \
      --add-flags "-m private_gpt"
  '';
}))

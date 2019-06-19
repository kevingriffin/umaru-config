{ elasticsearch, elkVersion,
  fetchurl, unzip, stdenv }:

let
  # Copied from the internals of elasticsearch
  esPlugin = a@{
    pluginName,
    installPhase ? ''
      mkdir -p $out/config
      mkdir -p $out/plugins
      ES_HOME=$out ${elasticsearch}/bin/elasticsearch-plugin install --batch -v file://$src
    '',
    ...
  }:
    stdenv.mkDerivation (a // {
      inherit installPhase;
      unpackPhase = "true";
      buildInputs = [ unzip ];
      meta = a.meta // {
        platforms = elasticsearch.meta.platforms;
      };
  });

  analysis_smartcn = esPlugin rec {
    name = "analysis-smartcn-${elkVersion}";
    pluginName = "analysis-smartcn";
    src = fetchurl {
      url = "https://artifacts.elastic.co/downloads/elasticsearch-plugins/analysis-smartcn/analysis-smartcn-${elkVersion}.zip";
      sha256 = {
        "5.6.9" = "1y4i9b8zxx26fjixcc7b82sxizl5hgvyqwzilgcb4cfnkap7dx8j";
        "5.6.16" = "1miijfslvj5cjb34221pky7xw6chhgbfcn48vhn3g0jfr6kcx824";
      }."${elkVersion}";
    };
    meta = {};
  };

  analysis_kuromoji = esPlugin rec {
    name = "analysis-kuromoji-${elkVersion}";
    pluginName = "analysis-kuromoji";
    src = fetchurl {
      url = "https://artifacts.elastic.co/downloads/elasticsearch-plugins/analysis-kuromoji/analysis-kuromoji-${elkVersion}.zip";
      sha256 = {
        "5.6.9" = "1avwn7y80l7pajxgxa1sb66r6h2cswbls9ygml2w7090wad8b3aa";
        "5.6.16" = "0hyv856ivzrw4gzsqp55a9h2xxcnsq2l00g954r2dcx38nv69ny7";
      }."${elkVersion}";
    };
    meta = {};
  };

in

[
  analysis_smartcn
  analysis_kuromoji
]

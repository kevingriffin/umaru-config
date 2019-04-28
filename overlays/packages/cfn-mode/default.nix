{ melpaBuild, flycheck, yaml-mode, json-mode, cfn-lint, writeText }:

melpaBuild rec {
  pname = "cfn-mode";
  version = "0.0";
  src = ./cfn-mode.el;
  # The github is a lie, but you need a repo for a recipe.
  recipe = writeText "recipe" "(cfn-mode :repo \"thefloweringash/cfn-mode\" :fetcher github)";
  packageRequires = [ flycheck yaml-mode json-mode ];
  propagatedUserEnvPkgs = [ cfn-lint ] ++ packageRequires;
}

{ lib, bundlerEnv, ruby }:

bundlerEnv rec {
  pname = "phraseapp_updater";

  inherit ruby;

  gemdir = ./.;

  meta = with lib; {
    description = "A tool for merging data on PhraseApp with local changes (usually two git revisions)";
    homepage = https://github.com/iknow/phraseapp_updater;
    license = licenses.mit;
    platforms = platforms.unix;
  };
}

{
  ast = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "184ssy3w93nkajlz2c70ifm79jp3j737294kbc5fjw69v1w0n9x7";
      type = "gem";
    };
    version = "2.4.0";
  };
  childprocess = {
    dependencies = ["ffi"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "081hxbgrqjxha0jz0p0wkncdqawdvlsxb3awsx195g0pgkpqrcms";
      type = "gem";
    };
    version = "0.8.0";
  };
  ffi = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "06mvxpjply8qh4j3fj9wh08kdzwkbnvsiysh0vrhlk5cwxzjmblh";
      type = "gem";
    };
    version = "1.11.1";
  };
  parser = {
    dependencies = ["ast"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1zjk0w1kjj3xk8ymy1430aa4gg0k8ckphfj88br6il4pm83f0n1f";
      type = "gem";
    };
    version = "2.5.3.0";
  };
  seeing_is_believing = {
    dependencies = ["childprocess" "parser"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "06g8ypg110a1fl3wgiqm3amhaka23ps5vc9pq7xsw96rldvh7868";
      type = "gem";
    };
    version = "3.6.1";
  };
}
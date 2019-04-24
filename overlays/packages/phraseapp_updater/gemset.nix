{
  deep_merge = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1q3picw7zx1xdkybmrnhmk2hycxzaa0jv4gqrby1s90dy5n7fmsb";
      type = "gem";
    };
    version = "1.2.1";
  };
  hashdiff = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "19ykg5pax8798nh1yv71adkx0zzs7gn2rxjj86v7nsw0jba5lask";
      type = "gem";
    };
    version = "0.3.8";
  };
  multi_json = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1rl0qy4inf1mp8mybfk56dfga0mvx97zwpmq5xmiwl5r770171nv";
      type = "gem";
    };
    version = "1.13.1";
  };
  oj = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1jli4mi1xpmm8564pc09bfvv7znzqghidwa3zfw21r365ihmbv2p";
      type = "gem";
    };
    version = "2.18.5";
  };
  parallel = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1x1gzgjrdlkm1aw0hfpyphsxcx90qgs3y4gmp9km3dvf4hc4qm8r";
      type = "gem";
    };
    version = "1.17.0";
  };
  phraseapp-ruby = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "14n2hhwjn32xk0qk6rprs3awnrddhnd4zckyd0a4j8lv8k648pnn";
      type = "gem";
    };
    version = "1.6.0";
  };
  phraseapp_updater = {
    dependencies = ["deep_merge" "hashdiff" "multi_json" "oj" "parallel" "phraseapp-ruby" "thor"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0xlw199dav6jxazwk5cbqciqpjv0fq8x4cap2xkhx8h475f5wbn4";
      type = "gem";
    };
    version = "2.0.7";
  };
  thor = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1yhrnp9x8qcy5vc7g438amd5j9sw83ih7c30dr6g6slgw9zj3g29";
      type = "gem";
    };
    version = "0.20.3";
  };
}
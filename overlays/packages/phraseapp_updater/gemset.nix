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
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0yj5l2rw8i8jc725hbcpc4wks0qlaaimr3dpaqamfjkjkxl0hjp9";
      type = "gem";
    };
    version = "0.3.7";
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
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "01hj8v1qnyl5ndrs33g8ld8ibk0rbcqdpkpznr04gkbxd11pqn67";
      type = "gem";
    };
    version = "1.12.1";
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
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1d6acgbqgylq96lm0zhx11icwmk9airwi25sgzj39aaaa9n7jkpp";
      type = "gem";
    };
    version = "2.0.4";
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
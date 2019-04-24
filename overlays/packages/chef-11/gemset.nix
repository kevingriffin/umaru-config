{
  chef = {
    dependencies = ["chef-zero" "diff-lcs" "erubis" "ffi-yajl" "highline" "mime-types" "mixlib-authentication" "mixlib-cli" "mixlib-config" "mixlib-log" "mixlib-shellout" "net-ssh" "net-ssh-multi" "ohai" "plist" "pry" "rest-client"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "00ikandfhdx6014b1ygh2yw8csgkrhxq4bfi6q8ssxpj958dv3dy";
      type = "gem";
    };
    version = "11.18.0";
  };
  chef-zero = {
    dependencies = ["ffi-yajl" "hashie" "mixlib-log" "rack"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0gyhair9pp9w0nvhbq0ncqq5pja78bkj5jfxmflyvh243cacx586";
      type = "gem";
    };
    version = "2.2.1";
  };
  coderay = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "15vav4bhcc2x3jmi3izb11l4d9f3xv8hp2fszb7iqmpsccv1pz4y";
      type = "gem";
    };
    version = "1.1.2";
  };
  diff-lcs = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "18w22bjz424gzafv6nzv98h0aqkwz3d9xhm7cbr1wfbyas8zayza";
      type = "gem";
    };
    version = "1.3";
  };
  erubis = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1fj827xqjs91yqsydf0zmfyw9p4l2jz5yikg3mppz6d7fi8kyrb3";
      type = "gem";
    };
    version = "2.7.0";
  };
  ffi = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0jpm2dis1j7zvvy3lg7axz9jml316zrn7s0j59vyq3qr127z0m7q";
      type = "gem";
    };
    version = "1.9.25";
  };
  ffi-yajl = {
    dependencies = ["ffi" "libyajl2"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1l289wyzc06v0rn73msqxx4gm48iqgxkd9rins22f13qicpczi5g";
      type = "gem";
    };
    version = "1.4.0";
  };
  hashie = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "08w9ask37zh5w989b6igair3zf8gwllyzix97rlabxglif9f9qd9";
      type = "gem";
    };
    version = "2.1.2";
  };
  highline = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "01ib7jp85xjc4gh4jg0wyzllm46hwv8p0w1m4c75pbgi41fps50y";
      type = "gem";
    };
    version = "1.7.10";
  };
  ipaddress = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1x86s0s11w202j6ka40jbmywkrx8fhq8xiy8mwvnkhllj57hqr45";
      type = "gem";
    };
    version = "0.8.3";
  };
  libyajl2 = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0n5j0p8dxf9xzb9n4bkdr8w0a8gg3jzrn9indri3n0fv90gcs5qi";
      type = "gem";
    };
    version = "1.2.0";
  };
  method_source = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1jk3vvgjh9qhf4bkal76p1g9fi8aqnhgr33wcddwkny0nb73ms91";
      type = "gem";
    };
    version = "0.9.1";
  };
  mime-types = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0mhzsanmnzdshaba7gmsjwnv168r1yj8y0flzw88frw1cickrvw8";
      type = "gem";
    };
    version = "1.25.1";
  };
  mixlib-authentication = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1lh8vrkq2nnf0rx69mlyiqkx664baxbp32imb7l517lbcw5xspgb";
      type = "gem";
    };
    version = "1.4.2";
  };
  mixlib-cli = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0647msh7kp7lzyf6m72g6snpirvhimjm22qb8xgv9pdhbcrmcccp";
      type = "gem";
    };
    version = "1.7.0";
  };
  mixlib-config = {
    dependencies = ["tomlrb"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "04fcjw2b4vii4mw5ncdpahpxprxg3r4jxkcf7ll86fm960bv37m8";
      type = "gem";
    };
    version = "2.2.13";
  };
  mixlib-log = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "14sknyi9r7rg28m21c8ixzyndhbmi0d6vk02y4hf42dd60hmdbgp";
      type = "gem";
    };
    version = "1.7.1";
  };
  mixlib-shellout = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0awwll2gbsvsz7g6j473f0xrjzyxq755vl260lmki6p937d33f7a";
      type = "gem";
    };
    version = "1.6.1";
  };
  net-ssh = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1xsjq4s3pn6m3fxx1xybyhy5axli1zcxpvmd3d88x552v2c8gb0j";
      type = "gem";
    };
    version = "2.9.4";
  };
  net-ssh-gateway = {
    dependencies = ["net-ssh"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "04ws9bvf3ppvcj9vrnwyabcwv4lz1m66ni443z2cf4wvvqssifsa";
      type = "gem";
    };
    version = "1.3.0";
  };
  net-ssh-multi = {
    dependencies = ["net-ssh" "net-ssh-gateway"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "13kxz9b6kgr9mcds44zpavbndxyi6pvyzyda6bhk1kfmb5c10m71";
      type = "gem";
    };
    version = "1.2.1";
  };
  ohai = {
    dependencies = ["ffi" "ffi-yajl" "ipaddress" "mime-types" "mixlib-cli" "mixlib-config" "mixlib-log" "mixlib-shellout" "systemu" "wmi-lite"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1rsmmzv06a60j7lgzlqmyvn6sxc51qlm68gjznkbaspnvbrry03p";
      type = "gem";
    };
    version = "7.4.1";
  };
  plist = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0rh8nddwdya888j1f4wix3dfan1rlana3mc7mwrvafxir88a1qcs";
      type = "gem";
    };
    version = "3.1.0";
  };
  pry = {
    dependencies = ["coderay" "method_source"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1417109nmp7sp8blbdhjx3ckkygm94x1fsfdqn3n7s6dgmc5c35y";
      type = "gem";
    };
    version = "0.12.0";
  };
  rack = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1pcgv8dv4vkaczzlix8q3j68capwhk420cddzijwqgi2qb4lm1zm";
      type = "gem";
    };
    version = "2.0.6";
  };
  rest-client = {
    dependencies = ["mime-types"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0nn7zalgidz2yj0iqh3xvzh626krm2al79dfiij19jdhp0rk8853";
      type = "gem";
    };
    version = "1.6.7";
  };
  systemu = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0gmkbakhfci5wnmbfx5i54f25j9zsvbw858yg3jjhfs5n4ad1xq1";
      type = "gem";
    };
    version = "2.6.5";
  };
  tomlrb = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1x3bg9mmma1gsl5j5kc9m8m77w6qwcq6ix2d0kwi5rcwpr7siyx6";
      type = "gem";
    };
    version = "1.2.7";
  };
  wmi-lite = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "06pm7jr2gcnphhhswha2kqw0vhxy91i68942s7gqriadbc8pq9z3";
      type = "gem";
    };
    version = "1.0.0";
  };
}
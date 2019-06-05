{
  aws-eventstream = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "0gdiwkg24jpx5f3bkw6vchgliicn6v9bpm09j0dldaxsca66q0wy";
      type = "gem";
    };
    version = "1.0.1";
  };
  aws-partitions = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "0adr55f159s45g662s7kx5ypvvkms624d45dhqchjqdzyy1ajh0a";
      type = "gem";
    };
    version = "1.136.0";
  };
  aws-sdk-core = {
    dependencies = ["aws-eventstream" "aws-partitions" "aws-sigv4" "jmespath"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "043c2011mzy29n5cc8frdfhiwihwkadz2nf6i87bk2ggl1siasqj";
      type = "gem";
    };
    version = "3.46.0";
  };
  aws-sdk-ec2 = {
    dependencies = ["aws-sdk-core" "aws-sigv4"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "0f4vj5338fj333dim9dmpqvwyxqp499l5ahwwpfg9fgfqmb7lg1r";
      type = "gem";
    };
    version = "1.67.0";
  };
  aws-sigv4 = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "1hzndv113i6bgy2n72i5l3mwn8vjnb6hhjxfkpn9mm2p5ra77yk7";
      type = "gem";
    };
    version = "1.0.3";
  };
  chef = {
    dependencies = ["chef-zero" "diff-lcs" "erubis" "ffi-yajl" "highline" "mime-types" "mixlib-authentication" "mixlib-cli" "mixlib-config" "mixlib-log" "mixlib-shellout" "net-ssh" "net-ssh-multi" "ohai" "plist" "pry" "rest-client"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "00ikandfhdx6014b1ygh2yw8csgkrhxq4bfi6q8ssxpj958dv3dy";
      type = "gem";
    };
    version = "11.18.0";
  };
  chef-zero = {
    dependencies = ["ffi-yajl" "hashie" "mixlib-log" "rack"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "0gyhair9pp9w0nvhbq0ncqq5pja78bkj5jfxmflyvh243cacx586";
      type = "gem";
    };
    version = "2.2.1";
  };
  coderay = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "15vav4bhcc2x3jmi3izb11l4d9f3xv8hp2fszb7iqmpsccv1pz4y";
      type = "gem";
    };
    version = "1.1.2";
  };
  colored = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "0b0x5jmsyi0z69bm6sij1k89z7h0laag3cb4mdn7zkl9qmxb90lx";
      type = "gem";
    };
    version = "1.2";
  };
  diff-lcs = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "18w22bjz424gzafv6nzv98h0aqkwz3d9xhm7cbr1wfbyas8zayza";
      type = "gem";
    };
    version = "1.3";
  };
  erubis = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "1fj827xqjs91yqsydf0zmfyw9p4l2jz5yikg3mppz6d7fi8kyrb3";
      type = "gem";
    };
    version = "2.7.0";
  };
  ffi = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "0j8pzj8raxbir5w5k6s7a042sb5k02pg0f8s4na1r5lan901j00p";
      type = "gem";
    };
    version = "1.10.0";
  };
  ffi-yajl = {
    dependencies = ["ffi" "libyajl2"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "1l289wyzc06v0rn73msqxx4gm48iqgxkd9rins22f13qicpczi5g";
      type = "gem";
    };
    version = "1.4.0";
  };
  hashie = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "08w9ask37zh5w989b6igair3zf8gwllyzix97rlabxglif9f9qd9";
      type = "gem";
    };
    version = "2.1.2";
  };
  highline = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "01ib7jp85xjc4gh4jg0wyzllm46hwv8p0w1m4c75pbgi41fps50y";
      type = "gem";
    };
    version = "1.7.10";
  };
  io-console = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "0mcnkhiyfv6lx95vca39pymdpr90ivwgilc0av6i5mp5biiyr7kk";
      type = "gem";
    };
    version = "0.4.5";
  };
  ipaddress = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "1x86s0s11w202j6ka40jbmywkrx8fhq8xiy8mwvnkhllj57hqr45";
      type = "gem";
    };
    version = "0.8.3";
  };
  jmespath = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "1d4wac0dcd1jf6kc57891glih9w57552zgqswgy74d1xhgnk0ngf";
      type = "gem";
    };
    version = "1.4.0";
  };
  libyajl2 = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "0n5j0p8dxf9xzb9n4bkdr8w0a8gg3jzrn9indri3n0fv90gcs5qi";
      type = "gem";
    };
    version = "1.2.0";
  };
  method_source = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "1pviwzvdqd90gn6y7illcdd9adapw8fczml933p5vl739dkvl3lq";
      type = "gem";
    };
    version = "0.9.2";
  };
  mime-types = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "0mhzsanmnzdshaba7gmsjwnv168r1yj8y0flzw88frw1cickrvw8";
      type = "gem";
    };
    version = "1.25.1";
  };
  mixlib-authentication = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "1lh8vrkq2nnf0rx69mlyiqkx664baxbp32imb7l517lbcw5xspgb";
      type = "gem";
    };
    version = "1.4.2";
  };
  mixlib-cli = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "0647msh7kp7lzyf6m72g6snpirvhimjm22qb8xgv9pdhbcrmcccp";
      type = "gem";
    };
    version = "1.7.0";
  };
  mixlib-config = {
    dependencies = ["tomlrb"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "1gm6yj9cbbgsl9x4xqxga0vz5w0ksq2jnq1wj8hvgm5c4wfcrswb";
      type = "gem";
    };
    version = "2.2.18";
  };
  mixlib-log = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "14sknyi9r7rg28m21c8ixzyndhbmi0d6vk02y4hf42dd60hmdbgp";
      type = "gem";
    };
    version = "1.7.1";
  };
  mixlib-shellout = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "0awwll2gbsvsz7g6j473f0xrjzyxq755vl260lmki6p937d33f7a";
      type = "gem";
    };
    version = "1.6.1";
  };
  net-ssh = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "1xsjq4s3pn6m3fxx1xybyhy5axli1zcxpvmd3d88x552v2c8gb0j";
      type = "gem";
    };
    version = "2.9.4";
  };
  net-ssh-gateway = {
    dependencies = ["net-ssh"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "04ws9bvf3ppvcj9vrnwyabcwv4lz1m66ni443z2cf4wvvqssifsa";
      type = "gem";
    };
    version = "1.3.0";
  };
  net-ssh-multi = {
    dependencies = ["net-ssh" "net-ssh-gateway"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "13kxz9b6kgr9mcds44zpavbndxyi6pvyzyda6bhk1kfmb5c10m71";
      type = "gem";
    };
    version = "1.2.1";
  };
  ohai = {
    dependencies = ["ffi" "ffi-yajl" "ipaddress" "mime-types" "mixlib-cli" "mixlib-config" "mixlib-log" "mixlib-shellout" "systemu" "wmi-lite"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "1rsmmzv06a60j7lgzlqmyvn6sxc51qlm68gjznkbaspnvbrry03p";
      type = "gem";
    };
    version = "7.4.1";
  };
  plist = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "0rh8nddwdya888j1f4wix3dfan1rlana3mc7mwrvafxir88a1qcs";
      type = "gem";
    };
    version = "3.1.0";
  };
  pry = {
    dependencies = ["coderay" "method_source"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "00rm71x0r1jdycwbs83lf9l6p494m99asakbvqxh8rz7zwnlzg69";
      type = "gem";
    };
    version = "0.12.2";
  };
  rack = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "1pcgv8dv4vkaczzlix8q3j68capwhk420cddzijwqgi2qb4lm1zm";
      type = "gem";
    };
    version = "2.0.6";
  };
  rest-client = {
    dependencies = ["mime-types"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "0nn7zalgidz2yj0iqh3xvzh626krm2al79dfiij19jdhp0rk8853";
      type = "gem";
    };
    version = "1.6.7";
  };
  systemu = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "0gmkbakhfci5wnmbfx5i54f25j9zsvbw858yg3jjhfs5n4ad1xq1";
      type = "gem";
    };
    version = "2.6.5";
  };
  tomlrb = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "0g28ssfal6vry3cmhy509ba3vi5d5aggz1gnffnvvmc8ml8vkpiv";
      type = "gem";
    };
    version = "1.2.8";
  };
  wmi-lite = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["http://rubygems.org"];
      sha256 = "1170npj167cvs6khlzn744jv422f9md1k822x2jnf75xbnz8z74h";
      type = "gem";
    };
    version = "1.0.2";
  };
}
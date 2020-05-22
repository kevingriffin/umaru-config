{
  addressable = {
    dependencies = ["public_suffix"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0viqszpkggqi8hq87pqp0xykhvz60g99nwmkwsb0v45kc2liwxvk";
      type = "gem";
    };
    version = "2.5.2";
  };
  airbrussh = {
    dependencies = ["sshkit"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1lhf60srldw4lmzar44fqq0d4cnxzdbr5ynp5ccpw7j6nz1gfs3i";
      type = "gem";
    };
    version = "1.3.1";
  };
  builder = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0qibi5s67lpdv1wgcj66wcymcr04q6j4mzws6a479n0mlrmh5wr1";
      type = "gem";
    };
    version = "3.2.3";
  };
  capistrano = {
    dependencies = ["airbrussh" "i18n" "rake" "sshkit"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "05gdwqp2fvcwaphsqnzj91cml5l5mccsii4m3zp0vzk5708nrz9x";
      type = "gem";
    };
    version = "3.8.1";
  };
  capistrano-bundler = {
    dependencies = ["capistrano" "sshkit"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "18vm7ssjcayb73yin5p5wa3cxdib5dp526wfjrc1zsvsicna5h42";
      type = "gem";
    };
    version = "1.4.0";
  };
  capistrano-chef = {
    dependencies = ["capistrano" "chef"];
    source = {
      fetchSubmodules = false;
      rev = "7efbb84c37a6e7133f3d8a8ff557487a187603ea";
      sha256 = "1m5frkn0nnzw5qagkkw3biaarsamgcg06y0m4h2qdaqg318gp734";
      type = "git";
      url = "git@github.com:iknow/capistrano-chef";
    };
    version = "1.0.0";
  };
  capistrano-npm = {
    dependencies = ["capistrano"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "028k7k1br0i6shc3h8vnlssim3d4pwbm0aap9v2f6wx1s5b906jg";
      type = "gem";
    };
    version = "1.0.2";
  };
  capistrano-rails = {
    dependencies = ["capistrano" "capistrano-bundler"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "19j82kiarrph1ilw2xfhfj62z0b53w0gph7613b21iccb2gn3dqy";
      type = "gem";
    };
    version = "1.4.0";
  };
  capistrano-yarn = {
    dependencies = ["capistrano"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1zdg2s061vl5b8114n909mrjb2hc1qx0i4wqx9nacsrcjgyp07l9";
      type = "gem";
    };
    version = "2.0.2";
  };
  chef = {
    dependencies = ["addressable" "chef-config" "chef-zero" "diff-lcs" "erubis" "ffi" "ffi-yajl" "highline" "iniparse" "mixlib-archive" "mixlib-authentication" "mixlib-cli" "mixlib-log" "mixlib-shellout" "net-sftp" "net-ssh" "net-ssh-multi" "ohai" "plist" "proxifier" "rspec-core" "rspec-expectations" "rspec-mocks" "rspec_junit_formatter" "serverspec" "specinfra" "syslog-logger" "uuidtools"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1jk88am20jrg18ccpq88cg2yg41pdi8fbl0ldfn35yr3x03067jm";
      type = "gem";
    };
    version = "14.6.47";
  };
  chef-config = {
    dependencies = ["addressable" "fuzzyurl" "mixlib-config" "mixlib-shellout" "tomlrb"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1b07553vnqxv4kia1d1wq900ylbfg8x15fcyw3nxsgn6db70a101";
      type = "gem";
    };
    version = "14.6.47";
  };
  chef-zero = {
    dependencies = ["ffi-yajl" "hashie" "mixlib-log" "rack" "uuidtools"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1dyhynsb4jq78x1rzcglxflzln49535zgh4mclvwg6mw2pkpl6jb";
      type = "gem";
    };
    version = "14.0.6";
  };
  concurrent-ruby = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "18q9skp5pfq4jwbxzmw8q2rn4cpw6mf4561i2hsjcl1nxdag2jvb";
      type = "gem";
    };
    version = "1.1.3";
  };
  diff-lcs = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "18w22bjz424gzafv6nzv98h0aqkwz3d9xhm7cbr1wfbyas8zayza";
      type = "gem";
    };
    version = "1.3";
  };
  docker-api = {
    dependencies = ["excon" "multi_json"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "04dkbg7x2m4102dnwil2v688gblxh1skh374nkzksn18jjrivkdp";
      type = "gem";
    };
    version = "1.34.2";
  };
  erubis = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1fj827xqjs91yqsydf0zmfyw9p4l2jz5yikg3mppz6d7fi8kyrb3";
      type = "gem";
    };
    version = "2.7.0";
  };
  excon = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "15l9w0938c19nxmrp09n75qpmm64k12xj69h47yvxzcxcpbgnkb2";
      type = "gem";
    };
    version = "0.62.0";
  };
  faraday = {
    dependencies = ["multipart-post"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "16hwxc8v0z6gkanckjhx0ffgqmzpc4ywz4dfhxpjlz2mbz8d5m52";
      type = "gem";
    };
    version = "0.15.3";
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
    dependencies = ["libyajl2"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0mv7h8bjzgv96kpbmgkmg43rwy96w54kg39vldcdwym6kpqyfgr5";
      type = "gem";
    };
    version = "2.3.1";
  };
  fuzzyurl = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "03qchs33vfwbsv5awxg3acfmlcrf5xbhnbrc83fdpamwya0glbjl";
      type = "gem";
    };
    version = "0.9.0";
  };
  hashie = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "13bdzfp25c8k51ayzxqkbzag3wj5gc1jd8h7d985nsq6pn57g5xh";
      type = "gem";
    };
    version = "3.6.0";
  };
  highline = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "01ib7jp85xjc4gh4jg0wyzllm46hwv8p0w1m4c75pbgi41fps50y";
      type = "gem";
    };
    version = "1.7.10";
  };
  honeybadger = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0rkfcrd3i5smvf3b5lza2hvgj8gnf1i0p49rn2srkwahifzpjh0g";
      type = "gem";
    };
    version = "4.1.0";
  };
  i18n = {
    dependencies = ["concurrent-ruby"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1gcp1m1p6dpasycfz2sj82ci9ggz7lsskz9c9q6gvfwxrl8y9dx7";
      type = "gem";
    };
    version = "1.1.1";
  };
  iniparse = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1xbik6838gfh5yq9ahh1m7dzszxlk0g7x5lvhb8amk60mafkrgws";
      type = "gem";
    };
    version = "1.4.4";
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
  mini_portile2 = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "13d32jjadpjj6d2wdhkfpsmy68zjx90p49bgf8f7nkpz86r1fr11";
      type = "gem";
    };
    version = "2.3.0";
  };
  mixlib-archive = {
    dependencies = ["mixlib-log"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0jcxxf0mh3a0mqsw28d7cnvszqwyx8gz846ychmfbn6di5rk1cnk";
      type = "gem";
    };
    version = "0.4.18";
  };
  mixlib-authentication = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0d6h4fmvcqglzpv1im0qrg1vzmkb02dl2hlsy799ra2j1lyrr6jy";
      type = "gem";
    };
    version = "2.1.1";
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
      sha256 = "02qyzl5r0d00qf98wkljg5fjsynl56nfyy122w55lf55dh4mwzj5";
      type = "gem";
    };
    version = "2.0.4";
  };
  mixlib-shellout = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "15fbphhln3mdqi8g7l2nxfwm0lhyglyxy79587x4cqwhahahkw1a";
      type = "gem";
    };
    version = "2.4.0";
  };
  multi_json = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1rl0qy4inf1mp8mybfk56dfga0mvx97zwpmq5xmiwl5r770171nv";
      type = "gem";
    };
    version = "1.13.1";
  };
  multipart-post = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "09k0b3cybqilk1gwrwwain95rdypixb2q9w65gd44gfzsd84xi1x";
      type = "gem";
    };
    version = "2.0.0";
  };
  net-scp = {
    dependencies = ["net-ssh"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0b0jqrcsp4bbi4n4mzyf70cp2ysyp6x07j8k8cqgxnvb4i3a134j";
      type = "gem";
    };
    version = "1.2.1";
  };
  net-sftp = {
    dependencies = ["net-ssh"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "04674g4n6mryjajlcd82af8g8k95la4b1bj712dh71hw1c9vhw1y";
      type = "gem";
    };
    version = "2.1.2";
  };
  net-ssh = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "07c4v97zl1daabmri9zlbzs6yvkl56z1q14bw74d53jdj0c17nhx";
      type = "gem";
    };
    version = "4.2.0";
  };
  net-ssh-gateway = {
    dependencies = ["net-ssh"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1l3v761y32aw0n8lm0c0m42lr4ay8cq6q4sc5yc68b9fwlfvb70x";
      type = "gem";
    };
    version = "2.0.0";
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
  net-telnet = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "13qxznpwmc3hs51b76wqx2w29r158gzzh8719kv2gpi56844c8fx";
      type = "gem";
    };
    version = "0.1.1";
  };
  nokogiri = {
    dependencies = ["mini_portile2"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0byyxrazkfm29ypcx5q4syrv126nvjnf7z6bqi01sqkv4llsi4qz";
      type = "gem";
    };
    version = "1.8.5";
  };
  octokit = {
    dependencies = ["sawyer"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1yh0yzzqg575ix3y2l2261b9ag82gv2v4f1wczdhcmfbxcz755x6";
      type = "gem";
    };
    version = "4.13.0";
  };
  ohai = {
    dependencies = ["chef-config" "ffi" "ffi-yajl" "ipaddress" "mixlib-cli" "mixlib-config" "mixlib-log" "mixlib-shellout" "plist" "systemu" "wmi-lite"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0k9kvqr7jbrbjqiff5nfi7xl7kn0s545bgizaalgkf5sr9y4y0jy";
      type = "gem";
    };
    version = "14.6.2";
  };
  plist = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1f27kj49v76psqxgcwvwc63cf7va2bszmmw2qrrd281qzi2if79l";
      type = "gem";
    };
    version = "3.4.0";
  };
  proxifier = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1abzlg39cfji1nx3i8kmb5k3anr2rd392yg2icms24wkqz9g9zj0";
      type = "gem";
    };
    version = "1.0.3";
  };
  public_suffix = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "08q64b5br692dd3v0a9wq9q5dvycc6kmiqmjbdxkxbfizggsvx6l";
      type = "gem";
    };
    version = "3.0.3";
  };
  rack = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1pcgv8dv4vkaczzlix8q3j68capwhk420cddzijwqgi2qb4lm1zm";
      type = "gem";
    };
    version = "2.0.6";
  };
  rake = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1idi53jay34ba9j68c3mfr9wwkg3cd9qh0fn9cg42hv72c6q8dyg";
      type = "gem";
    };
    version = "12.3.1";
  };
  rspec = {
    dependencies = ["rspec-core" "rspec-expectations" "rspec-mocks"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "15ppasvb9qrscwlyjz67ppw1lnxiqnkzx5vkx1bd8x5n3dhikxc3";
      type = "gem";
    };
    version = "3.8.0";
  };
  rspec-core = {
    dependencies = ["rspec-support"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1p1s5bnbqp3sxk67y0fh0x884jjym527r0vgmhbm81w7aq6b7l4p";
      type = "gem";
    };
    version = "3.8.0";
  };
  rspec-expectations = {
    dependencies = ["diff-lcs" "rspec-support"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "18l21hy1zdc2pgc2yb17k3n2al1khpfr0z6pijlm852iz6vj0dkm";
      type = "gem";
    };
    version = "3.8.2";
  };
  rspec-its = {
    dependencies = ["rspec-core" "rspec-expectations"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1pwphny5jawcm1hda3vs9pjv1cybaxy17dc1s75qd7drrvx697p3";
      type = "gem";
    };
    version = "1.2.0";
  };
  rspec-mocks = {
    dependencies = ["diff-lcs" "rspec-support"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "06y508cjqycb4yfhxmb3nxn0v9xqf17qbd46l1dh4xhncinr4fyp";
      type = "gem";
    };
    version = "3.8.0";
  };
  rspec-support = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0p3m7drixrlhvj2zpc38b11x145bvm311x6f33jjcxmvcm0wq609";
      type = "gem";
    };
    version = "3.8.0";
  };
  rspec_junit_formatter = {
    dependencies = ["builder" "rspec-core"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0hphl8iggqh1mpbbv0avf8735x6jgry5wmkqyzgv1zwnimvja1ai";
      type = "gem";
    };
    version = "0.2.3";
  };
  sawyer = {
    dependencies = ["addressable" "faraday"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0sv1463r7bqzvx4drqdmd36m7rrv6sf1v3c6vswpnq3k6vdw2dvd";
      type = "gem";
    };
    version = "0.8.1";
  };
  serverspec = {
    dependencies = ["multi_json" "rspec" "rspec-its" "specinfra"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1zsi7nb7mn6jsxbs6gbbkavmbnpdpk9xn2rsd5hbayzmqnb7qk43";
      type = "gem";
    };
    version = "2.41.3";
  };
  sfl = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1qm4hvhq9pszi9zs1cl9qgwx1n4wxq0af0hq9sbf6qihqd8rwwwr";
      type = "gem";
    };
    version = "2.3";
  };
  specinfra = {
    dependencies = ["net-scp" "net-ssh" "net-telnet" "sfl"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "05sjc253n0hpn4pjq8iz2q2ygn0ycf28v64x41n844sssc7167ln";
      type = "gem";
    };
    version = "2.76.3";
  };
  sshkit = {
    dependencies = ["net-scp" "net-ssh"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0w8wmi225clqjsii97820r582swlj86dp4pcl7asih0f5s561csm";
      type = "gem";
    };
    version = "1.18.0";
  };
  syslog-logger = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "14y20phq1khdla4z9wvf98k7j3x6n0rjgs4f7vb0xlf7h53g6hbm";
      type = "gem";
    };
    version = "1.6.8";
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
  uuidtools = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0zjvq1jrrnzj69ylmz1xcr30skf9ymmvjmdwbvscncd7zkr8av5g";
      type = "gem";
    };
    version = "2.1.5";
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

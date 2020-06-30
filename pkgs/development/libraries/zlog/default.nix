{ stdenv, fetchzip }:

stdenv.mkDerivation rec {
  version = "1.2.15";
  pname = "zlog";

  src = fetchzip {
    name = "${pname}-${version}-src";
    url = "https://github.com/HardySimpson/zlog/archive/${version}.tar.gz";
    sha256 = "10hzifgpml7jm43y6v8c8q0cr9ziyx9qxznafxyw6glhnlqnb7pb";
  };

  configurePhase = ''
    sed -i 's;-Werror;;' src/makefile
  '';

  buildPhase = ''
    mkdir -p $out
    make PREFIX=$out
  '';

  installPhase = ''
    make PREFIX=$out install
  '';

  meta = with stdenv.lib; {
    description= "Reliable, high-performance, thread safe, flexible, clear-model, pure C logging library";
    homepage = "http://hardysimpson.github.com/zlog";
    license = licenses.lgpl21;
    platforms = platforms.linux; # cannot test on something else
    maintainers = [ maintainers.matthiasbeyer ];
  };

}

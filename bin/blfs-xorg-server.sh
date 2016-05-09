#!/bin/bash
###
XORG_PREFIX="/usr"
XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"
#export XORG_PREFIX XORG_CONFIG
###

if [ ! -e /usr/include/expat.h ]; then
	wget http://prdownloads.sourceforge.net/expat/expat-2.1.0.tar.gz
	tar xvf expat-2.1.0.tar.gz
	cd expat-2.1.0
	./configure --prefix=/usr
	make 
	make install
	cd ..
	rm -rf expat-2.1.0
fi


wget http://www.openssl.org/source/openssl-1.0.1g.tar.gz
wget http://www.linuxfromscratch.org/patches/blfs/svn/openssl-1.0.1g-fix_parallel_build-1.patch
wget http://www.linuxfromscratch.org/patches/blfs/svn/openssl-1.0.1g-fix_pod_syntax-1.patch
tar xvf openssl-1.0.1g.tar.gz
cd openssl-1.0.1g
patch -Np1 -i ../openssl-1.0.1g-fix_parallel_build-1.patch && patch -Np1 -i ../openssl-1.0.1g-fix_pod_syntax-1.patch && ./config --prefix=/usr                  --openssldir=/etc/ssl          --libdir=lib                   shared                         zlib-dynamic && make
sed -i 's# libcrypto.a##;s# libssl.a##' Makefile
make MANDIR=/usr/share/man MANSUFFIX=ssl install && install -dv -m755 /usr/share/doc/openssl-1.0.1g  && cp -vfr doc/*     /usr/share/doc/openssl-1.0.1g

cd ..

#wget http://ftp.gnu.org/gnu/nettle/nettle-2.7.1.tar.gz
#tar xvf nettle-2.7.1.tar.gz 
#cd nettle-2.7.1
#./configure --prefix=/usr && make
#sed -i '/^install-here/ s/install-static//' Makefile
#make install && chmod -v 755 /usr/lib/libhogweed.so.2.5 /usr/lib/libnettle.so.4.7 && install -v -m755 -d /usr/share/doc/nettle-2.7.1 && install -v -m644 nettle.html /usr/share/doc/nettle-2.7.1

#cd ..

wget http://cairographics.org/releases/pixman-0.32.4.tar.gz
tar xvf pixman-0.32.4.tar.gz 
cd pixman-0.32.4
./configure --prefix=/usr --disable-static && make 
make install

cd ..

wget http://downloads.sourceforge.net/libpng/libpng-1.6.10.tar.xz
wget http://downloads.sourceforge.net/libpng-apng/libpng-1.6.10-apng.patch.gz
tar xvf libpng-1.6.10.tar.xz
cd libpng-1.6.10
gzip -cd ../libpng-1.6.10-apng.patch.gz | patch -p1
./configure --prefix=/usr --disable-static && make
make install && mkdir -v /usr/share/doc/libpng-1.6.10 && cp -v README libpng-manual.txt /usr/share/doc/libpng-1.6.10
cd ..

wget http://xmlsoft.org/sources/libxml2-2.9.1.tar.gz
tar xvf libxml2-2.9.1.tar.gz 
cd libxml2-2.9.1
./configure --prefix=/usr --disable-static --with-history && make
make install

cd ..

wget http://downloads.sourceforge.net/freetype/freetype-2.5.3.tar.bz2
tar xvf freetype-2.5.3.tar.bz2 
cd freetype-2.5.3
sed -i  -e "/AUX.*.gxvalid/s@^# @@" -e "/AUX.*.otvalid/s@^# @@" modules.cfg && sed -ri -e 's:.*(#.*SUBPIXEL.*) .*:\1:' include/config/ftoption.h && ./configure --prefix=/usr --disable-static && make
make install && install -v -m755 -d /usr/share/doc/freetype-2.5.3 && cp -v -R docs/*     /usr/share/doc/freetype-2.5.3

cd ..

wget http://www.freedesktop.org/software/fontconfig/release/fontconfig-2.11.1.tar.bz2
tar xvf fontconfig-2.11.1.tar.bz2 
cd fontconfig-2.11.1
./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var --disable-docs --docdir=/usr/share/doc/fontconfig-2.11.1 && make
make install

cd ..

wget http://xorg.freedesktop.org/releases/individual/util/util-macros-1.19.0.tar.bz2
tar xvf util-macros-1.19.0.tar.bz2 
cd util-macros-1.19.0
./configure $XORG_CONFIG
make install

cd ..

cat > proto-7.7.md5 << "EOF"
1a05fb01fa1d5198894c931cf925c025  bigreqsproto-1.1.2.tar.bz2
98482f65ba1e74a08bf5b056a4031ef0  compositeproto-0.4.2.tar.bz2
998e5904764b82642cc63d97b4ba9e95  damageproto-1.2.1.tar.bz2
4ee175bbd44d05c34d43bb129be5098a  dmxproto-2.3.1.tar.bz2
b2721d5d24c04d9980a0c6540cb5396a  dri2proto-2.8.tar.bz2
a3d2cbe60a9ca1bf3aea6c93c817fee3  dri3proto-1.0.tar.bz2
e7431ab84d37b2678af71e29355e101d  fixesproto-5.0.tar.bz2
36934d00b00555eaacde9f091f392f97  fontsproto-2.1.3.tar.bz2
5565f1b0facf4a59c2778229c1f70d10  glproto-1.4.17.tar.bz2
94db391e60044e140c9854203d080654  inputproto-2.3.tar.bz2
677ea8523eec6caca86121ad2dca0b71  kbproto-1.0.6.tar.bz2
2d569c75884455c7148d133d341e8fd6  presentproto-1.0.tar.bz2
ce4d0b05675968e4c83e003cc809660d  randrproto-1.4.0.tar.bz2
1b4e5dede5ea51906f1530ca1e21d216  recordproto-1.14.2.tar.bz2
a914ccc1de66ddeb4b611c6b0686e274  renderproto-0.11.1.tar.bz2
cfdb57dae221b71b2703f8e2980eaaf4  resourceproto-1.2.0.tar.bz2
edd8a73775e8ece1d69515dd17767bfb  scrnsaverproto-1.2.2.tar.bz2
e658641595327d3990eab70fdb55ca8b  videoproto-2.3.2.tar.bz2
5f4847c78e41b801982c8a5e06365b24  xcmiscproto-1.2.2.tar.bz2
70c90f313b4b0851758ef77b95019584  xextproto-7.3.0.tar.bz2
120e226ede5a4687b25dd357cc9b8efe  xf86bigfontproto-1.2.0.tar.bz2
a036dc2fcbf052ec10621fd48b68dbb1  xf86dgaproto-2.1.tar.bz2
1d716d0dac3b664e5ee20c69d34bc10e  xf86driproto-2.1.1.tar.bz2
e793ecefeaecfeabd1aed6a01095174e  xf86vidmodeproto-2.3.1.tar.bz2
9959fe0bfb22a0e7260433b8d199590a  xineramaproto-1.2.1.tar.bz2
4dc2464bfeade23dab5de38da0f6b1b5  xproto-7.0.26.tar.bz2
EOF
mkdir proto && cd proto && grep -v '^#' ../proto-7.7.md5 | awk '{print $2}' | wget -i- -c -B http://xorg.freedesktop.org/releases/individual/proto/ 
md5sum -c ../proto-7.7.md5

for package in $(grep -v '^#' ../proto-7.7.md5 | awk '{print $2}'); do   packagedir=${package%.tar.bz2};   tar -xf $package;   pushd $packagedir;   ./configure $XORG_CONFIG;   make install;   popd;   rm -rf $packagedir; done

cd ..

wget http://xorg.freedesktop.org/releases/individual/lib/libXau-1.0.8.tar.bz2
tar xvf libXau-1.0.8.tar.bz2 
cd libXau-1.0.8
./configure $XORG_CONFIG && make
make install

cd ..

wget --no-check-certificate  http://www.python.org/ftp/python/2.7.6/Python-2.7.6.tar.xz
tar xvf Python-2.7.6.tar.xz 
wget http://www.linuxfromscratch.org/patches/blfs/svn/Python-2.7.6-readline_6_3-1.patch
cd Python-2.7.6
patch -Np1 -i ../Python-2.7.6-readline_6_3-1.patch && ./configure --prefix=/usr --enable-shared --with-system-expat --with-system-ffi --enable-unicode=ucs4 && make
make install && chmod -v 755 /usr/lib/libpython2.7.so.1.0

cd ..

wget http://xcb.freedesktop.org/dist/xcb-proto-1.10.tar.bz2
tar xvf xcb-proto-1.10.tar.bz2 
cd xcb-proto-1.10
./configure $XORG_CONFIG
make install

cd ..

wget http://xcb.freedesktop.org/dist/libxcb-1.10.tar.bz2
tar xvf libxcb-1.10.tar.bz2 
cd libxcb-1.10
sed -e "s/pthread-stubs//" -i configure.ac && autoreconf -fiv && ./configure $XORG_CONFIG --docdir='${datadir}'/doc/libxcb-1.10 --enable-xinput --enable-xkb && make
make install

cd ..

cat > lib-7.7.md5 << "EOF"
a615e17d9fee6f097fc3b716eacb3dca  xtrans-1.3.4.tar.bz2
c35d6ad95b06635a524579e88622fdb5  libX11-1.6.2.tar.bz2
4376101e51bb2c6c44d9ab14344e85ad  libXext-1.3.2.tar.bz2
a8a0dbd2299b2568d8c919883f5c8501  libFS-1.0.6.tar.bz2
471b5ca9f5562ac0d6eac7a0bf650738  libICE-1.0.8.tar.bz2
499a7773c65aba513609fe651853c5f3  libSM-1.2.2.tar.bz2
7a773b16165e39e938650bcc9027c1d5  libXScrnSaver-1.2.2.tar.bz2
03149823ae57bb02d0cec90d5b97d56c  libXt-1.1.4.tar.bz2
41d92ab627dfa06568076043f3e089e4  libXmu-1.1.2.tar.bz2
769ee12a43611cdebd38094eaf83f3f0  libXpm-3.5.11.tar.bz2
7446f5fba888672aad068b29c0928ba3  libXaw-1.0.12.tar.bz2
b985b85f8b9386c85ddcfe1073906b4d  libXfixes-5.0.1.tar.bz2
f7a218dcbf6f0848599c6c36fc65c51a  libXcomposite-0.4.4.tar.bz2
2bd9a15fcf64d216e63b8d129e4f1f1c  libXrender-0.9.8.tar.bz2
1e7c17afbbce83e2215917047c57d1b3  libXcursor-1.1.14.tar.bz2
0cf292de2a9fa2e9a939aefde68fd34f  libXdamage-1.1.4.tar.bz2
ad2919764933e075bb0361ad5caa3d19  libfontenc-1.1.2.tar.bz2
b21ee5739d5d2e5028b302fbf9fe630b  libXfont-1.4.7.tar.bz2
78d64dece560c9e8699199f3faa521c0  libXft-2.3.1.tar.bz2
f4df3532b1af1dcc905d804f55b30b4a  libXi-1.7.2.tar.bz2
9336dc46ae3bf5f81c247f7131461efd  libXinerama-1.1.3.tar.bz2
210ed9499a3d9c96e3a221629b7d39b0  libXrandr-1.4.2.tar.bz2
45ef29206a6b58254c81bea28ec6c95f  libXres-1.0.7.tar.bz2
25c6b366ac3dc7a12c5d79816ce96a59  libXtst-1.2.2.tar.bz2
e0af49d7d758b990e6fef629722d4aca  libXv-1.0.10.tar.bz2
2e4014e9d55c430e307999a6b3dd256d  libXvMC-1.0.8.tar.bz2
d7dd9b9df336b7dd4028b6b56542ff2c  libXxf86dga-1.1.4.tar.bz2
e46f6ee4f4567349a3189044fe1bb712  libXxf86vm-1.1.3.tar.bz2
ba983eba5a9f05d152a0725b8e863151  libdmx-1.1.3.tar.bz2
b7c0d3afce14eedca57312a3141ec13a  libpciaccess-0.13.2.tar.bz2
19e6533ae64abba0773816a23f2b9507  libxkbfile-1.0.8.tar.bz2
2dd10448c1166e71a176206a8dfabe6d  libxshmfence-1.1.tar.bz2
EOF
wget http://www.linuxfromscratch.org/patches/blfs/svn/libXfont-1.4.7-fontsproto_fix-2.patch
wget http://www.linuxfromscratch.org/patches/blfs/svn/libXft-2.3.1-freetype_fix-1.patch

mkdir lib && cd lib && grep -v '^#' ../lib-7.7.md5 | awk '{print $2}' | wget -i- -c -B http://xorg.freedesktop.org/releases/individual/lib/ && md5sum -c ../lib-7.7.md5

for package in $(grep -v '^#' ../lib-7.7.md5 | awk '{print $2}')
do
  packagedir=${package%.tar.bz2}
  tar -xf $package
  pushd $packagedir
  case $packagedir in
    libXfont-[0-9]* )
      patch -Np1 -i ../../libXfont-1.4.7-fontsproto_fix-2.patch
      ./configure $XORG_CONFIG --disable-devel-docs
    ;;
    libXft-[0-9]* )
      patch -Np1 -i ../../libXft-2.3.1-freetype_fix-1.patch
      ./configure $XORG_CONFIG
    ;;
    libXt-[0-9]* )
      ./configure $XORG_CONFIG \
                  --with-appdefaultdir=/etc/X11/app-defaults
    ;;
    * )
      ./configure $XORG_CONFIG
    ;;
  esac
  make
  make install
  popd
  rm -rf $packagedir
  /sbin/ldconfig
done

cd ..

wget http://dri.freedesktop.org/libdrm/libdrm-2.4.53.tar.bz2
tar xvf libdrm-2.4.53.tar.bz2 
cd libdrm-2.4.53
sed -e "/pthread-stubs/d" -i configure.ac && autoreconf -fiv && ./configure --prefix=/usr --enable-udev && make
make install

cd ..

wget ftp://ftp.freedesktop.org/pub/mesa/10.1.1/MesaLib-10.1.1.tar.bz2
wget http://www.linuxfromscratch.org/patches/blfs/svn/MesaLib-10.1.1-svga_texture-1.patch
tar xvf MesaLib-10.1.1.tar.bz2 
cd Mesa-10.1.1/
patch -Np1 -i ../MesaLib-10.1.1-svga_texture-1.patch 
./autogen.sh CFLAGS="-O2" CXXFLAGS="-O2" --prefix=$XORG_PREFIX --sysconfdir=/etc --enable-texture-float --enable-gles1 --enable-gles2 --enable-openvg --enable-osmesa --enable-xa --enable-gbm --enable-gallium-egl --enable-gallium-gbm --enable-glx-tls --with-egl-platforms="drm,x11" --with-gallium-drivers="nouveau,svga,swrast" 
make
make install

cd ..

wget http://xorg.freedesktop.org/archive/individual/data/xbitmaps-1.1.1.tar.bz2
tar xvf xbitmaps-1.1.1.tar.bz2 
cd xbitmaps-1.1.1
./configure $XORG_CONFIG
make install

cd ..

wget http://xcb.freedesktop.org/dist/xcb-util-0.3.9.tar.bz2
tar xvf xcb-util-0.3.9.tar.bz2 
cd xcb-util-0.3.9
./configure $XORG_CONFIG && make
make install

cd ..

cat > app-7.7.md5 << "EOF"
96a648a332160a7482885800f7a506fa  bdftopcf-1.0.4.tar.bz2
2527344acc60741a709f4858564c5ae6  iceauth-1.0.6.tar.bz2
c4a3664e08e5a47c120ff9263ee2f20c  luit-1.1.1.tar.bz2
18c429148c96c2079edda922a2b67632  mkfontdir-1.0.7.tar.bz2
03de3f15db678e277f5ef9c013aca1ad  mkfontscale-1.1.1.tar.bz2
f548e389ff68424947b87785df6a321b  sessreg-1.0.8.tar.bz2
1001771344608e120e943a396317c33a  setxkbmap-1.3.0.tar.bz2
edce41bd7562dcdfb813e05dbeede8ac  smproxy-1.0.5.tar.bz2
5c3c7431a38775caaea6051312a49bc9  x11perf-1.5.4.tar.bz2
7d6003f32838d5b688e2c8a131083271  xauth-1.0.9.tar.bz2
0066f23f69ca3ef62dcaeb74a87fdc48  xbacklight-1.2.1.tar.bz2
5812be48cbbec1068e7b718eec801766  xcmsdb-1.0.4.tar.bz2
09f56978a62854534deacc8aa8ff3031  xcursorgen-1.0.5.tar.bz2
cacc0733f16e4f2a97a5c430fcc4420e  xdpyinfo-1.3.1.tar.bz2
3d3cad4d754e10e325438193433d59fd  xdriinfo-1.0.4.tar.bz2
5b0a0b6f589441d546da21739fa75634  xev-1.2.1.tar.bz2
c06067f572bc4a5298f324f27340da95  xgamma-1.0.5.tar.bz2
f1669af1fe0554e876f03319c678e79d  xhost-1.0.6.tar.bz2
305980ac78a6954e306a14d80a54c441  xinput-1.6.1.tar.bz2
a0fc1ac3fc4fe479ade09674347c5aa0  xkbcomp-1.2.4.tar.bz2
37ed71525c63a9acd42e7cde211dcc5b  xkbevd-1.1.3.tar.bz2
502b14843f610af977dffc6cbf2102d5  xkbutils-1.0.4.tar.bz2
0ae6bc2a8d3af68e9c76b1a6ca5f7a78  xkill-1.0.4.tar.bz2
9d0e16d116d1c89e6b668c1b2672eb57  xlsatoms-1.1.1.tar.bz2
9fbf6b174a5138a61738a42e707ad8f5  xlsclients-1.1.3.tar.bz2
2dd5ae46fa18abc9331bc26250a25005  xmessage-1.0.4.tar.bz2
5511da3361eea4eaa21427652c559e1c  xmodmap-1.0.8.tar.bz2
6101f04731ffd40803df80eca274ec4b  xpr-1.0.4.tar.bz2
fae3d2fda07684027a643ca783d595cc  xprop-1.2.2.tar.bz2
78fd973d9b532106f8777a3449176148  xrandr-1.4.2.tar.bz2
b54c7e3e53b4f332d41ed435433fbda0  xrdb-1.1.0.tar.bz2
a896382bc53ef3e149eaf9b13bc81d42  xrefresh-1.0.5.tar.bz2
dcd227388b57487d543cab2fd7a602d7  xset-1.2.3.tar.bz2
7211b31ec70631829ebae9460999aa0b  xsetroot-1.1.1.tar.bz2
1fbd65e81323a8c0a4b5e24db0058405  xvinfo-1.1.2.tar.bz2
6b5d48464c5f366e91efd08b62b12d94  xwd-1.0.6.tar.bz2
b777bafb674555e48fd8437618270931  xwininfo-1.1.3.tar.bz2
3025b152b4f13fdffd0c46d0be587be6  xwud-1.0.4.tar.bz2
EOF
mkdir app && cd app && grep -v '^#' ../app-7.7.md5 | awk '{print $2}' | wget -i- -c -B http://xorg.freedesktop.org/releases/individual/app/ && md5sum -c ../app-7.7.md5

for package in $(grep -v '^#' ../app-7.7.md5 | awk '{print $2}')
do
  packagedir=${package%.tar.bz2}
  tar -xf $package
  pushd $packagedir
  case $packagedir in
    luit-[0-9]* )
      line1="#ifdef _XOPEN_SOURCE"
      line2="#  undef _XOPEN_SOURCE"
      line3="#  define _XOPEN_SOURCE 600"
      line4="#endif"
 
      sed -i -e "s@#ifdef HAVE_CONFIG_H@$line1\n$line2\n$line3\n$line4\n\n&@" sys.c
      unset line1 line2 line3 line4
    ;;
  esac
  ./configure $XORG_CONFIG
  make
  make install
  popd
  rm -rf $packagedir
done

cd ..

wget http://xorg.freedesktop.org/archive/individual/data/xcursor-themes-1.0.4.tar.bz2
tar xvf xcursor-themes-1.0.4.tar.bz2 
cd xcursor-themes-1.0.4
./configure $XORG_CONFIG && make
make install

cd ..

cat > font-7.7.md5 << "EOF"
ddfc8a89d597651408369d940d03d06b  font-util-1.3.0.tar.bz2
0f2d6546d514c5cc4ecf78a60657a5c1  encodings-1.0.4.tar.bz2
1347c3031b74c9e91dc4dfa53b12f143  font-adobe-100dpi-1.0.3.tar.bz2
6c9f26c92393c0756f3e8d614713495b  font-adobe-75dpi-1.0.3.tar.bz2
66fb6de561648a6dce2755621d6aea17  font-adobe-utopia-100dpi-1.0.4.tar.bz2
e99276db3e7cef6dccc8a57bc68aeba7  font-adobe-utopia-75dpi-1.0.4.tar.bz2
fcf24554c348df3c689b91596d7f9971  font-adobe-utopia-type1-1.0.4.tar.bz2
6d25f64796fef34b53b439c2e9efa562  font-alias-1.0.3.tar.bz2
cc0726e4a277d6ed93b8e09c1f195470  font-arabic-misc-1.0.3.tar.bz2
9f11ade089d689b9d59e0f47d26f39cd  font-bh-100dpi-1.0.3.tar.bz2
565494fc3b6ac08010201d79c677a7a7  font-bh-75dpi-1.0.3.tar.bz2
c8b73a53dcefe3e8d3907d3500e484a9  font-bh-lucidatypewriter-100dpi-1.0.3.tar.bz2
f6d65758ac9eb576ae49ab24c5e9019a  font-bh-lucidatypewriter-75dpi-1.0.3.tar.bz2
e8ca58ea0d3726b94fe9f2c17344be60  font-bh-ttf-1.0.3.tar.bz2
53ed9a42388b7ebb689bdfc374f96a22  font-bh-type1-1.0.3.tar.bz2
6b223a54b15ecbd5a1bc52312ad790d8  font-bitstream-100dpi-1.0.3.tar.bz2
d7c0588c26fac055c0dd683fdd65ac34  font-bitstream-75dpi-1.0.3.tar.bz2
5e0c9895d69d2632e2170114f8283c11  font-bitstream-type1-1.0.3.tar.bz2
e452b94b59b9cfd49110bb49b6267fba  font-cronyx-cyrillic-1.0.3.tar.bz2
3e0069d4f178a399cffe56daa95c2b63  font-cursor-misc-1.0.3.tar.bz2
0571bf77f8fab465a5454569d9989506  font-daewoo-misc-1.0.3.tar.bz2
6e7c5108f1b16d7a1c7b2c9760edd6e5  font-dec-misc-1.0.3.tar.bz2
bfb2593d2102585f45daa960f43cb3c4  font-ibm-type1-1.0.3.tar.bz2
a2401caccbdcf5698e001784dbd43f1a  font-isas-misc-1.0.3.tar.bz2
cb7b57d7800fd9e28ec35d85761ed278  font-jis-misc-1.0.3.tar.bz2
143c228286fe9c920ab60e47c1b60b67  font-micro-misc-1.0.3.tar.bz2
96109d0890ad2b6b0e948525ebb0aba8  font-misc-cyrillic-1.0.3.tar.bz2
6306c808f7d7e7d660dfb3859f9091d2  font-misc-ethiopic-1.0.3.tar.bz2
e3e7b0fda650adc7eb6964ff3c486b1c  font-misc-meltho-1.0.3.tar.bz2
c88eb44b3b903d79fb44b860a213e623  font-misc-misc-1.1.2.tar.bz2
56b0296e8862fc1df5cdbb4efe604e86  font-mutt-misc-1.0.3.tar.bz2
e805feb7c4f20e6bfb1118d19d972219  font-schumacher-misc-1.1.2.tar.bz2
6f3fdcf2454bf08128a651914b7948ca  font-screen-cyrillic-1.0.4.tar.bz2
beef61a9b0762aba8af7b736bb961f86  font-sony-misc-1.0.3.tar.bz2
948f2e07810b4f31195185921470f68d  font-sun-misc-1.0.3.tar.bz2
829a3159389b7f96f629e5388bfee67b  font-winitzki-cyrillic-1.0.3.tar.bz2
3eeb3fb44690b477d510bbd8f86cf5aa  font-xfree86-type1-1.0.4.tar.bz2
EOF
mkdir font && cd font && grep -v '^#' ../font-7.7.md5 | awk '{print $2}' | wget -i- -c -B http://xorg.freedesktop.org/releases/individual/font/ && md5sum -c ../font-7.7.md5

for package in $(grep -v '^#' ../font-7.7.md5 | awk '{print $2}')
do
  packagedir=${package%.tar.bz2}
  tar -xf $package
  pushd $packagedir
  ./configure $XORG_CONFIG
  make
  make install
  popd
  rm -rf $packagedir
done

install -v -d -m755 /usr/share/fonts                               &&
ln -svfn $XORG_PREFIX/share/fonts/X11/OTF /usr/share/fonts/X11-OTF &&
ln -svfn $XORG_PREFIX/share/fonts/X11/TTF /usr/share/fonts/X11-TTF

cd ..

wget http://xorg.freedesktop.org/archive/individual/data/xkeyboard-config/xkeyboard-config-2.11.tar.bz2
tar xvf xkeyboard-config-2.11.tar.bz2 
cd xkeyboard-config-2.11
./configure $XORG_CONFIG --with-xkb-rules-symlink=xorg && make
make install

cd ..

wget http://xorg.freedesktop.org/archive/individual/xserver/xorg-server-1.15.1.tar.bz2
wget http://www.linuxfromscratch.org/patches/blfs/svn/xorg-server-1.15.1-add_prime_support-1.patch
tar xvf xorg-server-1.15.1.tar.bz2 
cd xorg-server-1.15.1
patch -Np1 -i ../xorg-server-1.15.1-add_prime_support-1.patch
./configure $XORG_CONFIG --with-xkb-output=/var/lib/xkb --enable-install-setuid && make

make install && mkdir -pv /etc/X11/xorg.conf.d &&
cat >> /etc/sysconfig/createfiles << "EOF"
/tmp/.ICE-unix dir 1777 root root
/tmp/.X11-unix dir 1777 root root
EOF

cd ..

wget http://xorg.freedesktop.org/releases/individual/app/xinit-1.3.3.tar.bz2
tar xvf xinit-1.3.3.tar.bz2 
cd xinit-1.3.3
./configure $XORG_CONFIG --with-xinitdir=/etc/X11/app-defaults && make
make install

cd ..


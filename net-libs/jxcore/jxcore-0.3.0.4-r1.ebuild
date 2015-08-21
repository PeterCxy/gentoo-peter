# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

# Has known failures
RESTRICT="test mirror"

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="threads"

inherit pax-utils python-single-r1 toolchain-funcs

DESCRIPTION="Evented I/O for (SpiderMonkey, V8, and..) JavaScript"
HOMEPAGE="http://jxcore.com/home/"
SRC_URI="https://github.com/jxcore/jxcore/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="-debug icu +snapshot +ssl mozjs"

RDEPEND="
	icu? ( dev-libs/icu )
	${PYTHON_DEPS}
	ssl? ( dev-libs/openssl:0=[-bindist] )
	>=net-libs/http-parser-2.3
"
DEPEND="
	${RDEPEND}
	!!net-libs/iojs
	!!net-libs/nodejs
"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

src_prepare(){
	tc-export CC CXX PKG_CONFIG
	export V=1 # Verbose build
	export BUILDTYPE=Release

	# Switch to python2
	sed -i -e "s/python/${EPYTHON}/" deps/npm/node_modules/node-gyp/gyp/gyp || die
	sed -i -e "s/|| 'python'/|| '${EPYTHON}'/" deps/npm/node_modules/node-gyp/lib/configure.js || die

	# Less verbose
	sed -i -e "/print/d" tools/install.py || die

	# Proper libdir
	local LIBDIR=$(get_libdir)
	sed -i -e "s|lib/|${LIBDIR}/|g" tools/install.py || die
	sed -i -e "s/'lib'/'${LIBDIR}'/" lib/module.js || die
	sed -i -e "s|\"lib\"|\"${LIBDIR}\"|" deps/npm/lib/npm.js || die

	# debug builds. change install path, remove optimisations and override buildtype
	if use debug; then
		sed -i -e "s|out/Release/|out/Debug/|g" tools/install.py || die
		BUILDTYPE=Debug
	fi
}

src_configure(){
	local myconf=()
	local myarch=""
	use debug && myconf+=( --debug )
	use icu && myconf+=( --with-intl=system-icu )
	use snapshot || myconf+=( --without-snapshot )
	use ssl || myconf+=( --without-ssl )

	# Optional mozjs
	use mozjs && myconf+=( --engine-mozilla )

	case ${ABI} in
		x86) myarch="ia32";;
		amd64) myarch="x64";;
		arm) myarch="arm";;
		*) die "Unrecognized ARCH ${ARCH}";;
	esac

	"${PYTHON}" configure \
			--prefix="${EPREFIX}"/usr \
			--dest-cpu=${myarch} \
			--shared-openssl \
			--shared-http-parser \
			--shared-zlib \
			--without-dtrace \
			"${myconf[@]}" || die
}

src_compile(){
	emake -C out
}

src_install(){
	local LIBDIR="${ED}/usr/$(get_libdir)"
	emake install DESTDIR="${ED}" PREFIX=/usr
	
	dosym /usr/bin/jx /usr/bin/node

	# set up a symlink structure that npm expects..
	dodir /usr/include/node/deps/{v8,uv}
	dosym . /usr/include/node/src
	for var in deps/{uv,v8}/include; do
		dosym ../.. /usr/include/node/${var}
	done
}

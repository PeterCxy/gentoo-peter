# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit python-any-r1 unpacker

DESCRIPTION="A hackable text editor for the 21st Century by GitHub"
HOMEPAGE="https://atom.io"
SRC_URI="( https://github.com/atom/atom/releases/download/v${PV}/atom-amd64.deb -> ${P}.deb )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RESTRICT="mirror"

DEPEND="
	${PYTHON_DEPS}
	>=gnome-base/gconf-3.2.6-r3
	x11-libs/gtk+:2
	virtual/libudev
	dev-libs/libgcrypt
	x11-libs/libnotify
	x11-libs/libXtst
	dev-libs/nss
	gnome-base/libgnome-keyring
	gnome-base/gvfs
	x11-misc/xdg-utils
"
RDEPEND="${DEPEND}"

# HACK: unpacker will unpack the deb to ${WORKDIR}
S=${WORKDIR}

src_install(){
	dobin ${S}/usr/bin/atom
	insinto /usr
	insopts -m0755
	doins -r ${S}/usr/share
	dosym /usr/share/atom/resources/app/apm/bin/apm /usr/bin/apm
}

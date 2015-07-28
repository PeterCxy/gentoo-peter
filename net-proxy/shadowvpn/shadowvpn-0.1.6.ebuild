# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2

EGIT_REPO_URI="git://github.com/clowwindy/shadowvpn.git"
EGIT_COMMIT="0.1.6"

DESCRIPTION="A fast, safe VPN based on libsodium"
HOMEPAGE="http://shadowvpn.org/"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="systemd"

DEPEND="dev-libs/libsodium"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -e 's|SUBDIRS = ../libsodium||' \
		-e 's|AM_CFLAGS = .*libsodium.*$|AM_CFLAGS = -lsodium|' \
		-e 's|libshadowvpn_la_LIBADD = ../libsodium/src/libsodium/libsodium.la||' \
		-i src/Makefile.am
  
	sed -e 's|AC_CONFIG_SUBDIRS([libsodium])||' \
		-i configure.ac 
}

src_configure() {
	./autogen.sh
	econf \
		--sysconfdir=/etc --disable-static --prefix=/usr
}

src_install() {
	default

	if use systemd; then
		insinto "/usr/lib/systemd/system/"
		newins "${FILESDIR}/shadowvpn.service" shadowvpn@.service
	fi
}

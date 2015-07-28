# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils systemd

DESCRIPTION="Free server for AnyConnect"
HOMEPAGE="http://www.infradead.org/ocserv/"
SRC_URI="ftp://ftp.infradead.org/pub/ocserv/ocserv-${PV}.tar.xz -> ${PN}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="systemd"
RESTRICT="mirror"

DEPEND="
	net-libs/gnutls
"
RDEPEND="${DEPEND}"

src_install() {
	default

	insinto "/etc/ocserv"
	newins "${S}/doc/sample.config" config

	if use systemd ; then
		systemd_dounit "${FILESDIR}/ocserv.service"
	fi
}

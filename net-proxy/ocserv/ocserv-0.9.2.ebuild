# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Free server for AnyConnect"
HOMEPAGE="http://www.infradead.org/ocserv/"
SRC_URI="ftp://ftp.infradead.org/pub/ocserv/ocserv-${PV}.tar.xz -> ${PN}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RESTRICT="mirror"

DEPEND="
	net-libs/gnutls
"
RDEPEND="${DEPEND}"

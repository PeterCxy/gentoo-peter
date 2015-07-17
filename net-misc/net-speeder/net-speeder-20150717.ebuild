# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

EGIT_REPO_URI="git://github.com/snooda/net-speeder.git"
EGIT_COMMIT="8b100eabf6"

DESCRIPTION="Net packet doubler"
HOMEPAGE="https://github.com/snooda/net-speeder"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="cooked systemd"

DEPEND="
	net-libs/libnet
	net-libs/libpcap
"
RDEPEND="${DEPEND}"

src_compile(){
	if use cooked ; then
		sh ${S}/build.sh -DCOOKED
	else
		sh ${S}/build.sh
	fi
}

src_install(){
	mv ${S}/net_speeder ${D}/net-speeder
	dobin ${D}/net-speeder

	if use systemd ; then
		insinto "/usr/lib/systemd/system/"
		newins "${FILESDIR}/net-speeder.service" net-speeder@.service
	fi
}

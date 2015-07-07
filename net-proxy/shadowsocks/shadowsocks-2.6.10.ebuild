# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit git-r3 distutils-r1 eutils

DESCRIPTION=" A fast tunnel proxy that helps you bypass firewalls"
HOMEPAGE="http://shadowsocks.org/"

EGIT_REPO_URI="git://github.com/shadowsocks/shadowsocks.git"
EGIT_COMMIT="${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="systemd"

RDEPEND="
	dev-libs/openssl
	dev-libs/libsodium
	systemd? ( sys-apps/systemd )
"

DEPEND="${RDEPEND}
	dev-python/setuptools
"

src_install() {
	distutils-r1_src_install

	if use systemd ; then
		insinto "/etc/shadowsocks/"
		newins "${FILESDIR}/example.json" example.json

		insinto "/usr/lib/systemd/system/"
		newins "${FILESDIR}/ssserver.service" ssserver@.service
		newins "${FILESDIR}/sslocal.service" sslocal@.service
	fi
}

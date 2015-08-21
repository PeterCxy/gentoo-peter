# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Go port of shadowsocks"
HOMEPAGE="https://github.com/shadowsocks/shadowsocks-go"
SRC_URI=""

LICENSE="Unknown"
SLOT="0"
KEYWORDS="~amd64"
IUSE="systemd"

RDEPEND="
	dev-lang/go
"
DEPEND="
	${RDEPEND}
	dev-vcs/git
	dev-vcs/mercurial
"

src_unpack(){
	mkdir ${S}
}

src_compile(){
	GOPATH=${WORKDIR} go get -v -work github.com/shadowsocks/shadowsocks-go/cmd/shadowsocks-server
	GOPATH=${WORKDIR} go get -v -work github.com/shadowsocks/shadowsocks-go/cmd/shadowsocks-local
}

src_install(){
	dobin ${WORKDIR}/bin/shadowsocks-server
	dobin ${WORKDIR}/bin/shadowsocks-local

	# Install systemd service
	if use systemd; then
		insinto "/etc/shadowsocks"
		newins "${FILESDIR}/example.json" example.json

		insinto "/usr/lib/systemd/system/"
		newins "${FILESDIR}/ssserver.service" ssserver@.service
		newins "${FILESDIR}/sslocal.service" sslocal@.service
	fi
}

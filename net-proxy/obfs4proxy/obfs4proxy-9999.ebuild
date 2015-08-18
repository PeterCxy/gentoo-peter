# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="The obfourscator"
HOMEPAGE="https://gitweb.torproject.org/pluggable-transports/obfs4.git/"
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

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
	GOPATH=${WORKDIR} go get -v -work git.torproject.org/pluggable-transports/obfs4.git/obfs4proxy
}

src_install(){
	dobin ${WORKDIR}/bin/obfs4proxy
}

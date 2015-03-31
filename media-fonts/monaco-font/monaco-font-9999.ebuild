# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit font

DESCRIPTION="Monaco font"
HOMEPAGE="http://jorrel.blogspot.it/2007/11/monaco-on-ubuntu.html"
SRC_URI="https://github.com/PeterCxy/monaco-font/raw/master/Monaco_Linux.ttf -> ${PN}.ttf"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
RESTRICT="strip binchecks mirror"

S="${WORKDIR}"
FONT_S="${S}"
FONT_SUFFIX="ttf"

src_unpack() {
	cp -a "${DISTDIR}/${A}" "${S}/${A}"
}

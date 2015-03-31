# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

DESCRIPTION="Icon theme for gnome-themes-paper"
HOMEPAGE="http://snwh.org/paper/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/snwh/paper-icon-theme"
EGIT_COMMIT="1dac0b201d1aecbd498d9fb30f97287049e427c3"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	git-r3_src_unpack
}

src_install() {
	insinto /usr/share/icons
	doins -r ./Paper
	dodoc README.md
}

# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

DESCRIPTION="A Gnome and GTK2/3 theme inspired by Google's Material Design"
HOMEPAGE="http://snwh.org/paper/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/snwh/paper-gtk-theme"
EGIT_COMMIT="480dada57d7a0beac985f50116edab3cef94223a"

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
	insinto /usr/share/themes
	doins -r ./Paper
	dodoc README.md
}

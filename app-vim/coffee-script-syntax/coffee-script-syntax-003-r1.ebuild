# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

#VIM_PLUGIN_VIM_VERSION="7.0"
inherit vim-plugin git-r3

EGIT_REPO_URI="git://github.com/kchmck/vim-coffee-script.git"
EGIT_COMMIT="v${PV}"

DESCRIPTION="vim syntax for CoffeeScript"
HOMEPAGE="https://github.com/kchmck/vim-coffee-script"
LICENSE="WTFPL"
KEYWORDS="~amd64"
IUSE="vim-syntax"
SRC_URI=""

VIM_HELPFILES="coffee-script"
VIM_PLUGIN_MESSAGES="filetype"

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	default

	epatch "${FILESDIR}/0001-adds-yield-keyword.patch"
}

pkg_postinst() {
	vim-plugin_pkg_postinst
}

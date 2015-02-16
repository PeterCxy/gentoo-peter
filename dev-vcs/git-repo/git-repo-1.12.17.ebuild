# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit git-r3 python-any-r1

DESCRIPTION="A multiple git repository manager from the Android Open Source Project"
HOMEPAGE="https://android.googlesource.com/tools/repo"
SRC_URI=""
EGIT_REPO_URI="https://android.googlesource.com/tools/repo"
EGIT_COMMIT="v${PV}"

LICENSE="APACHE"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND="
	${PYTHON_DEPS}
	dev-vcs/git
"
RDEPEND="${DEPEND}"

src_unpack() {
	git-r3_src_unpack
}

src_install() {
	dobin repo
}

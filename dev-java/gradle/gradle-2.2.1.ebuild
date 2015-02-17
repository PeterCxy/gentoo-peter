# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit java-pkg-2

DESCRIPTION="A construction tool based on Groovy"
HOMEPAGE="https://gradle.org"
SRC_URI="http://services.gradle.org/distributions/${P}-all.zip -> ${P}.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"
IUSE="source doc examples"

RESTRICT="mirror"

DEPEND="
	app-arch/zip
	>=virtual/jdk-1.5
"
RDEPEND="${DEPEND}"

src_install(){
	insinto /usr/share/gradle
	use source && java-pkg_dosrc src/*
	use doc && java-pkg_dojavadoc docs
	use examples && java-pkg_doexamples samples
	cd lib
	for jar in *.jar; do
		java-pkg_newjar ${jar} ${jar}
	done
	insinto /usr/share/gradle/lib/plugins
	doins plugins/*
	cd ..
	cp -Rp bin "${D}/usr/share/gradle" || die "failed to copy"
	dodir /usr/bin
	dosym "/usr/share/gradle/bin/gradle" /usr/bin/gradle
}

# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils versionator

SR=R
RNAME="2024-03"

DESCRIPTION="Eclipse IDE for C/C++"
HOMEPAGE="http://www.eclipse.org"

SRC_BASE="https://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/${RNAME}/R/eclipse-cpp-${RNAME}-R-linux-gtk"
#SRC_BASE="https://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/${PV}/R/eclipse-cpp-${PV}-R-linux-gtk"
SRC_URI="
	amd64? ( ${SRC_BASE}-x86_64.tar.gz&r=1 -> ${P}-x86_64.tar.gz )
"
LICENSE="EPL-1.0"
SLOT=${PV}
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	dev-java/java-config
"
#	>=virtual/jdk-1.8
#	x11-libs/gtk+:2
RDEPEND="${DEPEND}"
S=${WORKDIR}/eclipse

src_install() {
	local dest=/opt/${PN}-${SLOT}

	insinto ${dest}
	doins -r features icon.xpm plugins artifacts.xml p2 eclipse.ini configuration dropins

	exeinto ${dest}
	doexe eclipse

	dohtml -r readme/*

#	cp "${FILESDIR}"/eclipserc-bin-${SLOT} "${T}" || die
#	cp "${FILESDIR}"/eclipse-bin-${SLOT} "${T}" || die
#	sed "s@%SLOT%@${SLOT}@" -i "${T}"/eclipse{,rc}-bin-${SLOT} || die

#	insinto /etc
#	newins "${T}"/eclipserc-bin-${SLOT} eclipserc-bin-${SLOT}

#	newbin "${T}"/eclipse-bin-${SLOT} eclipse-cpp-${SLOT}
	newicon  "icon.xpm" "${PN}.xpm"
	make_wrapper ${PN} "${dest}/eclipse"
#	make_desktop_entry "eclipse-cpp-${SLOT}" "Eclipse C/C++ IDE" "${dest}/icon.xpm" "Development;IDE"
	make_desktop_entry ${PN} "Eclipse C/C++ IDE ${PV}" "${dest}/icon.xpm" "Development;IDE"
}


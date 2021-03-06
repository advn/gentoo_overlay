# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils versionator

RNAME="neon"
SR=$(get_version_component_range 3 $PV)

DESCRIPTION="Eclipse IDE for C/C++"
HOMEPAGE="http://www.eclipse.org"

SRC_BASE="http://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/${RNAME}/${SR}/eclipse-cpp-${RNAME}-${SR}-linux-gtk"

SRC_URI="
	amd64? ( ${SRC_BASE}-x86_64.tar.gz&r=1 -> ${P}-x86_64.tar.gz )
	x86? ( ${SRC_BASE}.tar.gz&r=1 -> ${P}.tar.gz )
"

LICENSE="EPL-1.0"
SLOT="4.6"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=virtual/jdk-1.8
	x11-libs/gtk+:2
	dev-java/java-config
"

S=${WORKDIR}/eclipse

pkg_postinst() {
	echo 
	echo "This is Development Version"
	echo
}
src_install() {
	local dest=/opt/${PN}-${SLOT}

	insinto ${dest}
	doins -r features icon.xpm plugins artifacts.xml p2 eclipse.ini configuration dropins

	exeinto ${dest}
	doexe eclipse

	dohtml -r readme/*

	newicon  "icon.xpm" "${PN}.xpm"
	make_wrapper ${PN} "${dest}/eclipse"
	make_desktop_entry ${PN} "Eclipse Cpp ${PV}" ${PN} "Development;IDE"

#	cp "${FILESDIR}"/eclipserc-bin-${SLOT} "${T}" || die
#	cp "${FILESDIR}"/eclipse-bin-${SLOT} "${T}" || die
#	sed "s@%SLOT%@${SLOT}@" -i "${T}"/eclipse{,rc}-bin-${SLOT} || die

#	insinto /etc
#	newins "${T}"/eclipserc-bin-${SLOT} eclipserc-bin-${SLOT}

#	newbin "${T}"/eclipse-bin-${SLOT} eclipse-cpp-${SLOT}
#	make_desktop_entry "eclipse-cpp-${SLOT}" "Eclipse C/C++ IDE" "${dest}/icon.xpm" "Development;IDE"
}


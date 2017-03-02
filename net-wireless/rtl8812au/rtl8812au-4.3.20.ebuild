# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

#inherit eutils linux-mod user git-r3
inherit linux-mod git-r3

DESCRIPTION="Driver for Realtek 8812au USB Wifi dongles"
HOMEPAGE="https://github.com/Grawp/rtl8812au_rtl8821au"

EGIT_REPO_URI="https://github.com/Grawp/rtl8812au_rtl8821au.git"
EGIT_BRANCH=${PV}
#EGIT_REPO_URI="git://github.com/grawp/${PN}_rtl8821au.git"
#EGIT_SOURCEDIR="${WORKDIR}/all"
#SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm ~amd64 ~x86"
IUSE=""
#IUSE="pax_kernel"

DEPEND=""
RDEPEND="${DEPEND}"

#S=${WORKDIR}

BUILD_TARGETS="all"
BUILD_TARGET_ARCH="${ARCH}"
MODULE_NAMES="rtl8812au(net/wireless:)"
#MODULE_NAMES="rtl8812au(net/wireless:${S})"

pkg_setup() {
    linux-mod_pkg_setup
	
	BUILD_PARAMS="KERN_DIR=${KV_DIR} O=${KV_OUT_DIR} V=1 KBUILD_VERBOSE=1"
}

src_install() {
    linux-mod_src_install
}

pkg_postinst() {
    linux-mod_pkg_postinst
}

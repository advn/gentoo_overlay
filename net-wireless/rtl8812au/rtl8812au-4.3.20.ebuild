# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit linux-mod git-r3

DESCRIPTION="Driver for Realtek 8812au USB Wifi dongles"
HOMEPAGE="https://github.com/Grawp/rtl8812au_rtl8821au"

EGIT_REPO_URI="https://github.com/Grawp/rtl8812au_rtl8821au.git"
EGIT_BRANCH=${PV}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm ~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

BUILD_TARGETS="all"
BUILD_TARGET_ARCH="${ARCH}"
MODULE_NAMES="8812au(net/wireless:)"

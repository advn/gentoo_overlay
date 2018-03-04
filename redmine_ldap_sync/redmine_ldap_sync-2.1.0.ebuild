# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

USE_RUBY="ruby21 ruby23 ruby24"
inherit ruby-ng user

DESCRIPTION=" A redmine plugin to synchronize both users and groups with an ldap server."
HOMEPAGE="https://github.com/thorin/redmine_ldap_sync"

GH_OWNR="thorin"
if [ "${PV}" = "2.0.7" ] || [ "${PV}" = "9999" ]; then
	EGIT_REPO_URI="https://github.com/thorin/${PN}.git"
	inherit git-2
	EGIT_SOURCEDIR="${WORKDIR}/all"
	SRC_URI=""
else
#	SRC_URI="https://github.com/thorin/${PN}/tarball/master -> ${PV}.tar.gz"
	SRC_URI="https://api.github.com/repos/${GH_OWNR}/${PN}/tarball/${PV} -> ${P}.tar.gz"
fi

KEYWORDS=""

LICENSE="GPL-3.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend "www-apps/redmine"

REDMINE_DIR="/var/lib/redmine"

pkg_setup() {
	enewgroup redmine
	enewuser redmine -1 -1 "${REDMINE_DIR}" redmine
}

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}/${GH_OWNR}-${PN}-18b49e8" "${WORKDIR}/all"
}

all_ruby_unpack() {
	git-2_src_unpack
}

all_ruby_install() {
	dodoc README.md
	rm .gitignore README.md LICENSE .travis.yml .coveralls.yml || die
	dodir "${REDMINE_DIR}"/plugins/${PN}
	insinto "${REDMINE_DIR}"/plugins/${PN}
	doins -r .
	fowners -R redmine:redmine "${REDMINE_DIR}"/plugins/${PN}
}

pkg_postinst() {
	einfo
	elog "Please run emerge --config =${PF}"
	einfo
}

pkg_config() {
	local RAILS_ENV=${RAILS_ENV:-production}
	if [ ! -L /usr/bin/ruby ]; then
		eerror "/usr/bin/ruby is not a valid symlink to any ruby implementation."
		eerror "Please update it via `eselect ruby`"
		die
	fi
	if [[ $RUBY_TARGETS != *$( eselect ruby show | awk 'NR==2' | tr  -d ' '  )* ]]; then
		eerror "/usr/bin/ruby is currently not included in redmine's ruby targets: ${RUBY_TARGETS}."
		eerror "Please update it via `eselect ruby`"
		die
	fi

	local RUBY=${RUBY:-ruby}
	einfo "Upgrading the plugin migrations."
	cd "${EPREFIX}${REDMINE_DIR}" || die
	RAILS_ENV="${RAILS_ENV}" ${RUBY} -S rake redmine:plugins:migrate || die
}


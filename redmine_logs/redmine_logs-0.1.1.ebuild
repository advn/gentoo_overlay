# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

USE_RUBY="ruby21 ruby23 ruby24"
inherit ruby-ng user

DESCRIPTION="A plugin lets you download Redmine's log files from administration page"
HOMEPAGE="http://www.r-labs.org/projects/logs https://bitbucket.org/haru_iida/redmine_logs"
#SRC_URI="https://github.com/haru/redmine_logs/downloads/${P}.zip"
GH_OWNR="haru"
SRC_URI="https://api.github.com/repos/${GH_OWNR}/${PN}/tarball/${PV} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND+=" app-arch/unzip"

ruby_add_rdepend "
	>=www-apps/redmine-3"

REDMINE_DIR="/var/lib/redmine"

RUBY_S=${PN}

pkg_setup() {
	enewgroup redmine
	enewuser redmine -1 -1 "${REDMINE_DIR}" redmine
}

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}/${GH_OWNR}-${PN}-bfda23b" "${WORKDIR}/all"
}

all_ruby_install() {
	dodoc README.rdoc
	rm README.rdoc GPL.txt .flow || die
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

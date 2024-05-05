EAPI=8
PYTHON_COMPAT=( python3_{8..12} pypy3 ) 

inherit distutils-r1 pypi

DESCRIPTION="convert components from EasyEDA or LCSC for use with KiCad"
HOMEPAGE="https://github.com/uPesy/easyeda2kicad.py"
DISTUTILS_USE_PEP517=setuptools

LICENSE="AGPL-3.0"
SLOT="0"
KEYWORDS="amd64"

RDEPEND=">=dev-vcs/pre-commit-2.17.0
	 >=dev-python/pydantic-1.5
	 >dev-python/requests-2.0.0"
DEPEND=""


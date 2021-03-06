#!/bin/sh

if [ $# -ne 1 ]; then
    >&2 echo "usage: $0 <version>"
    exit 1
fi

set -xe

python3 --version
git --version

version=$1

sed -i "s/version = .*/version = '${version}'/" setup.py
python3 setup.py clean
python3 setup.py test
python3 setup.py flake8

git add setup.py

git commit -m "Bumped version to $version"
git push

python3 setup.py sdist bdist_wheel upload

git tag ${version}
git push --tags

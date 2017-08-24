#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function setup_repo {
    repo=$1
    tmp_folder=$(mktemp -d)
    echo $tmp_folder
    git clone $repo $tmp_folder
    cd $tmp_folder
    ./setup.sh
    rm -rf $tmp_folder
}

cd $DIR
REPOS="repos.txt"
while IFS= read -r line; do
    setup_repo $line
done < $REPOS

function install_package {
    package=$1
    apt-get install -y $package
}

cd $DIR
PACKAGES="packages.txt"
while IFS= read -r line; do
    install_package $line
done < $PACKAGES

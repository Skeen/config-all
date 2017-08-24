#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function setup_repo {
    repo=$1
    name=$(echo $repo | sed "s#.*/\(.*\)\.git#\1#g")
    echo "Setting up: $name"
    echo "-----------------"
    tmp_folder=$(mktemp -d)
    echo $tmp_folder
    git clone $repo $tmp_folder
    cd $tmp_folder
    ./setup.sh
    cd $HOME
    rm -rf $tmp_folder
    echo ""
}

function install_repos {
    cd $DIR
    REPOS="repos.txt"
    while IFS= read -r line; do
        setup_repo $line
    done < $REPOS
}

function install_package {
    package=$(echo $1 | tr -d '[:space:]')
    sudo apt-get install -y "$package"
}

function install_packages {
    cd $DIR
    PACKAGES="packages.txt"
    while IFS= read -r line; do
        install_package $line
    done < $PACKAGES
}

install_repos
install_packages

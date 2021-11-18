#!/bin/bash

arch=x86_64
package_name=zfs-linux

#get currently running kernel version
current_version=$(uname -r | tr - .)

# check latest kernel version in official arch repos
arch_repo_version=$(curl -s https://archlinux.org/packages/core/$arch/linux/ | grep "<h2>" | grep -oiE "[[:digit:]\.]+arch[[:digit:]-]+" | tr - .)

if [ "$arch_repo_version" = "$current_version" ]; then
    echo "Kernel up to date"
    exit 0
fi

# check latest supported kernel version by archzfs package
archzfs_version=$(curl -s https://archzfs.com/archzfs/$arch/ | grep -oiE "$package_name-[[:digit:]][0-9\.\_arch]+-" | head -1 | grep -oP "(?<=_)[0-9\.\-arch]+(?=\-)")

# compare versions and print result
if [ "$arch_repo_version" = "$archzfs_version" ]; then
    echo "Kernel upgrade available"
else
    echo "ZFS module out of sync"
fi

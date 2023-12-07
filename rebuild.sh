#!/bin/bash

function edit() {
    make -j`nproc` package/kernel/mac80211/{clean,prepare} V=s QUILT=1
    cd build_dir/target-aarch64_cortex-a53_musl/linux-ipq807x_generic/backports-6.1.24
    quilt push -a
    echo "* patches applied"
    echo "* add files to patches before editing! existing patches for mac80211 and ath:"
    quilt series | grep -E "80211|ath"
    echo "* now cd into build_dir/target-aarch64_cortex-a53_musl/linux-ipq807x_generic/backports-6.1.24 and edit"
}

function install() {
    cd build_dir/target-aarch64_cortex-a53_musl/linux-ipq807x_generic/backports-6.1.24
    quilt refresh
    cd ../../../../
    make -j`nproc` package/kernel/mac80211/update V=s
    make -j`nproc` V=s
    echo "* image built, copy to AP"
    scp bin/targets/ipq807x/generic/openwrt-23.05.0-ipq807x-generic-xiaomi_ax3600-squashfs-sysupgrade.bin root@192.168.1.1:/tmp/
    echo "* image installed, ssh into AP and run `sysupgrade`"
}

# set -xe

command="$1"

case "$command" in
    edit)
        edit
        ;;
    install)
        install
        ;;
    *) 
        echo "Unknown command: $command"
        echo "Usage: $0 [edit|install]"
        echo ""
        exit 1
        ;;
esac

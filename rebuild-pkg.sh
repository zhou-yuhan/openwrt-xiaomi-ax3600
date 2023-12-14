pkg_name=$1

make package/${pkg_name}/compile V=s

pkg_bin=$(ls bin/packages/aarch64_cortex-a53/rt_streaming/ | grep $pkg_name)

echo "Compile done, copying package ..."

scp bin/packages/aarch64_cortex-a53/rt_streaming/${pkg_bin} root@192.168.1.1:/tmp
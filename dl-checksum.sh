#!/usr/bin/env sh
DIR=~/Downloads
APP=rke

dl()
{
    local mirror=$1
    local lchecksums=$2
    local os=$3
    local arch=$4
    local suffix=${5-}
    local file=${APP}_${os}-${arch}${suffix}
    local url=$mirror/$file

    printf "    # %s\n" $url
    printf "    %s-%s: sha256:%s\n" $os $arch `egrep -e "$file\$" $lchecksums | awk '{print $1}'`
}

dl_ver () {
    local ver=$1
    local mirror=https://github.com/rancher/${APP}/releases/download/$ver
    local lchecksums=$DIR/${APP}-checksums-${ver}.txt
    if [ ! -e $lchecksums ]
    then
        curl -sSLf -o $lchecksums $mirror/sha256sum.txt
    fi

    printf "  %s:\n" $ver
    dl $mirror $lchecksums linux amd64
    dl $mirror $lchecksums linux arm
    dl $mirror $lchecksums linux arm64
    dl $mirror $lchecksums darwin amd64
    dl $mirror $lchecksums windows 386 .exe
    dl $mirror $lchecksums windows amd64 .exe
}

dl_ver ${1:-v1.5.3}

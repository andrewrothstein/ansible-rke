#!/usr/bin/env sh
set -e
DIR=~/Downloads
MIRROR=https://github.com/rancher/rke/releases/download

dl()
{
    local ver=$1
    local os=$2
    local arch=$3
    local dotexe=${4-}
    local platform="${os}-${arch}"

    # https://github.com/rancher/rke/releases/download/v1.6.0/rke_linux-amd64
    local url="${MIRROR}/${ver}/rke_${platform}${dotexe}"
    local lfile="${DIR}/rke-${ver}_${platform}${dotexe}"

    if [ ! -e $lfile ];
    then
        curl -sSLf -o "${lfile}" "${url}"
    fi

    printf "    # %s\n" $url
    printf "    %s: sha256:%s\n" $platform $(sha256sum $lfile | awk '{print $1}')
}

dl_ver () {
    local ver=$1

    printf "  %s:\n" $ver
    dl $ver linux amd64
    dl $ver linux arm
    dl $ver linux arm64
    dl $ver darwin amd64
    dl $ver windows 386 .exe
    dl $ver windows amd64 .exe
}

dl_ver ${1:-v1.6.3}

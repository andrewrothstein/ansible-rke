#!/usr/bin/env sh
VER=v0.2.8
DIR=~/Downloads
MIRROR=https://github.com/rancher/rke/releases/download/$VER
LCHECKSUMS=$DIR/rke-checksums-$VER.txt

if [ ! -e $LCHECKSUMS ]
then
    wget -q -O $LCHECKSUMS $MIRROR/sha256sum.txt
fi

dl()
{
    OS=$1
    PLATFORM=$2
    SUFFIX=${3:-}

    FILE=rke_$OS-$PLATFORM$SUFFIX
    URL=$MIRROR/$FILE

    printf "    # %s\n" $URL
    printf "    %s-%s: sha256:%s\n" $OS $PLATFORM `fgrep $FILE $LCHECKSUMS | awk '{print $1}'`
}

printf "  %s:\n" $VER
dl linux amd64
dl linux arm
dl linux arm64
dl darwin amd64
dl windows 386 .exe
dl windows amd64 .exe



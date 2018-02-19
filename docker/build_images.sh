#!/usr/bin/env bash
set -eux

docker build -f dockerfiles/wine.dockerfile  -t starcraft:wine   .
docker build -f dockerfiles/bwapi.dockerfile -t starcraft:bwapi  .
docker build -f dockerfiles/play.dockerfile  -t starcraft:play   .
docker build -f dockerfiles/java.dockerfile  -t starcraft:java   .

[ ! -f jre-8u161-windows-i586.tar.gz ] && curl -L -b "oraclelicense=a" 'http://download.oracle.com/otn-pub/java/jdk/8u161-b12/2f38c3b165be4555a1fa6e98c45e0808/jre-8u161-windows-i586.tar.gz' -o jre-8u161-windows-i586.tar.gz

pushd ../scbw/local_docker
[ ! -f starcraft.zip ] && curl -SL 'http://files.theabyss.ru/sc/starcraft.zip' -o starcraft.zip
docker build -f game.dockerfile  -t "starcraft:game" .
popd

#!/bin/sh

VER=${1}
HASH=${2}

for f in $(ls Dockerfile.*); do
  TMP=$(mktemp)
  cat ${f} | sed -E "s/MAVEN_VERSION=\"[0-9](\.[0-9]){1,2}\"/MAVEN_VERSION=\"${VER}\"/g" \
           | sed -E "s/MAVEN_SHA512SUM=\"[0-9a-zA-Z]*\"/MAVEN_SHA512SUM=\"${HASH}\"/g" > ${TMP}
  cat ${TMP} > ${f}
  rm -f ${TMP}
done

TMP=$(mktemp)
cat hooks/build | sed -E "s/MAVEN_VERSION=\"[0-9](\.[0-9]){1,2}\"/MAVEN_VERSION=\"${VER}\"/g" \
                | sed -E "s/MAVEN_SHA512SUM=\"[0-9a-zA-Z]*\"/MAVEN_SHA512SUM=\"${HASH}\"/g" > ${TMP}
cat ${TMP} > hooks/build
rm -f ${TMP}

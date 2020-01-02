#!/bin/sh

GRADLE_VERSION=${1}
GRADLE_SHA256=${2}

for f in $(ls Dockerfile.*); do
  TMP=$(mktemp)
  cat ${f} | sed -E "s/GRADLE_VERSION=\"[0-9](\.[0-9]){1,2}\"/GRADLE_VERSION=\"${GRADLE_VERSION}\"/g" \
           | sed -E "s/GRADLE_SHA256=\"[0-9a-zA-Z]*\"/GRADLE_SHA256=\"${GRADLE_SHA256}\"/g" > ${TMP}
  cat ${TMP} > ${f}
  rm -f ${TMP}
done

TMP=$(mktemp)
cat hooks/build | sed -E "s/GRADLE_VERSION=\"[0-9](\.[0-9]){1,2}\"/GRADLE_VERSION=\"${GRADLE_VERSION}\"/g" \
                | sed -E "s/GRADLE_SHA256=\"[0-9a-zA-Z]*\"/GRADLE_SHA256=\"${GRADLE_SHA256}\"/g" > ${TMP}
cat ${TMP} > hooks/build
rm -f ${TMP}

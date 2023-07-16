#!/bin/bash -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Actual content
USERGUIDE_INPUT_DIR=$DIR/userguide
BUILD_DIR=$DIR/build
SELFCONTAINED_BUILD_DIR=$BUILD_DIR/selfcontained

DIR_OPTS="-B $USERGUIDE_INPUT_DIR -D $SELFCONTAINED_BUILD_DIR -a sourcedir=$USERGUIDE_INPUT_DIR -a imagesdir=$USERGUIDE_INPUT_DIR/assets"
EXTRA_OPTS="--trace -w --failure-level WARN -T html5 -a doctype=book -a data-uri"

SELFCONTAINED_BUILD="bundle exec asciidoctor $DIR_OPTS $EXTRA_OPTS"

# Setup
rm -rf $BUILD_DIR && mkdir -p $BUILD_DIR

for dir in `find $USERGUIDE_INPUT_DIR -maxdepth 1 -type d \! -name assets \! -name common`; do
  for doc in `find $dir -maxdepth 1 -type f -name '*.adoc'`; do
    echo "Building $doc"
    $SELFCONTAINED_BUILD $doc
  done
done

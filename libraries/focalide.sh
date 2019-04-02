#!/bin/bash

BIN="$(pwd)/../dkcheck.native -q"
SRC="https://deducteam.github.io/data/libraries/focalide.tar.gz"
DIR="focalide"

# Cleaning command (clean and exit).
if [[ "$#" -eq 1 && ("$1" = "clean" || "$1" = "fullclean") ]]; then
  rm -rf ${DIR}
  if [[ "$1" = "fullclean" ]]; then
    rm -f focalide.tar.gz
  fi
  exit 0
fi

# Rejecting other command line arguments.
if [[ "$#" -ne 0 ]]; then
  echo "Invalid argument, usage: $0 [clean | fullclean]"
  exit -1
fi

# Prepare the library if necessary.
if [[ ! -d ${DIR} ]]; then
  # The directory is not ready, so we need to work.
  echo "Preparing the library:"

  # Download the library if necessary.
  if [[ ! -f focalide.tar.gz ]]; then
    echo -n "  - downloading...      "
    wget -q ${SRC}
    echo "OK"
  fi

  # Extracting the source files.
  echo -n "  - extracting...       "
  tar xf focalide.tar.gz
  mv focalide_dks focalide
  echo "OK"

  # Applying the changes (add "#REQUIRE" and create "focalide.dk").
  echo -n "  - applying changes... "
  mv ${DIR}/modulogic.dk ${DIR}/zen.dk
  echo "OK"

  # All done.
  echo "Ready."
  echo ""
fi

cd ${DIR}
if [[ $TIME = "" ]]; then
	export TIME="Finished in %E at %P with %MKb of RAM"
fi

# Run the actual checks.
if [[ $OUT = "" ]]; then
	\time make "DKCHECK=$BIN"
else
	\time -a -o $OUT make "DKCHECK=$BIN"
fi

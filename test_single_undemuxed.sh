#!/usr/bin/env bash
cmd=$(which rainbow_bridge.nf)
prof=${1:-""}
if [[ -n "$prof" ]]; then
  prof="-profile $prof"
fi

if [[ -z "$cmd" ]]; then
  echo "pulling rainbow_bridge from https://github.com/mhoban/rainbow_bridge"
  cmd="nextflow run $prof mhoban/rainbow_bridge -r main"
else
  cmd="$cmd $prof"
fi

mkdir -p single_test_undemux
cd single_test_undemux

$cmd \
  --single \
  --ignore-blast-env \
  --reads '../fastq/single_undemux/test_30000reads.fastq' \
  --barcode '../se_bc_*' \
  --blast-db ../blastdb/single_undemuxed \
  --collapse-taxonomy

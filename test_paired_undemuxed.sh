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

mkdir -p paired_test_undemux
cd paired_test_undemux

$cmd \
  --paired \
  --ignore-blast-env \
  --reads ../fastq/paired_undemux \
  --barcode '../pe_bc_*' \
  --blast-db ../blastdb/paired_undemuxed \
  --collapse-taxonomy

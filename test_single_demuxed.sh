#!/usr/bin/env bash
cmd=$(which rainbow_bridge.nf)
prof=${1:-""}
if [[ -n "$prof" ]]; then
  prof="-profile $prof"
fi

if [[ -z "$cmd" ]]; then
  cmd="nextflow run $prof mhoban/rainbow_bridge -r main"
else
  cmd="$cmd -profile $prof"
fi

mkdir -p single_test_demux
cd single_test_demux

$cmd \
  --single \
  --ignore-blast-env \
  --illumina-demultiplexed \
  --reads '../fastq/single_demuxed/*.fastq' \
  --barcode ../single_demuxed_barcode.tab \
  --blast-db ../blastdb/single_demuxed \
  --collapse-taxonomy

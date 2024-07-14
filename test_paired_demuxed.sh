#!/usr/bin/env bash

mkdir -p paired_test_demux
cd paired_test_demux

../../rainbow_bridge.nf \
  --paired \
  --illumina-demultiplexed \
  --ignore-blast-env \
  --reads ../fastq/paired_demuxed \
  --sample-map ../paired_demuxed_sample.map \
  --barcode ../paired_demuxed_barcode.tab \
  --blast-db ../blastdb/paired_demuxed \
  --collapse-taxonomy

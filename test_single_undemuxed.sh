#!/usr/bin/env bash

mkdir -p single_test_undemux
cd single_test_undemux

../../rainbow_bridge.nf \
  --single \
  --ignore-blast-env \
  --reads '../fastq/single_undemux/test_30000reads.fastq' \
  --barcode '../se_bc_*' \
  --blast-db ../blastdb/single_undemuxed \
  --collapse-taxonomy

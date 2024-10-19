#!/usr/bin/env bash

# get rainbow_bridge executable
rb=${1:-$(which rainbow_bridge.nf)}

# parameter values to replace
to_replace=( barcode blast-db fwd reads rev sample-map )  

# loop over yaml files
for yml in *.yml; do
  # make a subdirectory for the test run
  dir=$(basename "$yml" .yml)
  mkdir -p test/$dir
  # copy the yaml file into the subdirectory
  params=$(readlink -m test/$dir/$(basename $yml))
  cp $yml $params
  # now make the paths relative to the new directory
  for k in ${to_replace[@]}; do
    sed -i -E "s/^${k}: ([\"'])?(.+)([\"'])?\$/${k}: \1..\/..\/\2\3/" $params
  done
  # go into the directory and run the pipeline
  pushd test/$dir >/dev/null
  echo "running test for $dir"
  $rb -params-file $params
  rm $params
  echo -e "\n\n"
  # back out to the starting dir
  popd >/dev/null
done

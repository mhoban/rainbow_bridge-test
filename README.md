# Test data for the `rainbow_bridge` metabarcoding pipeline.

This repository contains data that you can use to test your installation of the [rainbow_bridge](https://github.com/mhoban/rainbow_bridge) metabarcoding pipeline. Here you will find test datasets for each of the possible input scenarios supported by `rainbow_bridge`:

* Single-end sequencing runs
  * Demultiplexed
  * Undemultiplexed
* Paired-end sequencing runs
  * Demultiplexed
  * Undemultiplexed

The pipeline assumes that for undemultiplexed datasets you have used barcoded primers (see [obitools](https://pythonhosted.org/OBITools/scripts/ngsfilter.html) documentation for more info) and for demultiplexed datasets, your samples were separated using Illumina indices (for more information, see the README for `rainbow_bridge`). 

To test your installation, run the pipeline using one of the several YAML parameter files in the repository. The filenames should be self-explanatory (e.g., `paired_undemuxed.yml`, `single_demuxed.yml`, etc.). Your system will need to have `rainbow_bridge`'s dependencies installed (see the `rainbow_bridge` README for information). You can run `rainbow_bridge` either directly from the command line if you have cloned the repository or using netflow's built-in [github support](https://www.nextflow.io/docs/latest/sharing.html#running-a-pipeline) (in which case, the pipeline will be cloned to `$HOME/.nextflow/assets`). 

To run the scripts, open a terminal, change into the directory where this repository is cloned, and run the pipeline using the appropriate profile and parameter file. You can see which options are used for each input scenario by viewing the contents of the YAML files (options in the YAML file correspond to the pipeline's command-line options). Each example uses a custom BLAST database to save processing time. Taxonomy has been arbitrarily assigned to the test zOTU sequences in these databases, so if you try to query them against the actual NCBI database, you'll get very different results. 

By default, the pipeline will use the singularity container engine. If you want to use podman (or a different user-defined profile), pass the appropriate profile name using the `-profile` argument to the pipeline. The profiles supported by `rainbow_bridge` out of the box (in addition to the default) are `podman_arm` and `podman_intel`, which use the podman container engine on either ARM or intel CPU architecture respectively.

Here is a worked example including the sort of output you should expect to see. Here, the `rainbow_bridge` repository has NOT been cloned to the local machine and nextflow will pull it from github automatically:

```console
$ cd rainbow_bridge-test
$ nextflow run -params-file single_demuxed.yml mhoban/rainbow_bridge -r main
 N E X T F L O W   ~  version 24.04.3

Pulling mhoban/rainbow_bridge ...
 downloaded from https://github.com/mhoban/rainbow_bridge.git
WARN: It appears you have never run this project before -- Option `-resume` is ignored
Launching `https://github.com/mhoban/rainbow_bridge` [tiny_wright] DSL2 - revision: a160ca1ad5 [main]

executor >  local (84)
[-        ] process > unzip                 -
[95/f43afb] process > filter_merge (19)     [100%] 19 of 19 ✔
[6b/560f50] process > ngsfilter (19)        [100%] 19 of 19 ✔
[a6/5d4824] process > filter_length (19)    [100%] 19 of 19 ✔
[67/95b2cf] process > relabel_vsearch (18)  [100%] 19 of 19 ✔
[d8/ea469b] process > derep_vsearch (1)     [100%] 1 of 1 ✔
[b5/114709] process > get_taxdb             [100%] 1 of 1 ✔
[f8/e26b89] process > blast (1)             [100%] 1 of 1 ✔
[43/a0286f] process > lulu_blast (1)        [100%] 1 of 1 ✔
[c2/51df49] process > lulu (1)              [100%] 1 of 1 ✔
[1c/ce00ce] process > get_lineage           [100%] 1 of 1 ✔
[e1/0ffbb3] process > collapse_taxonomy (1) [100%] 1 of 1 ✔
[13/b5323e] process > finalize (1)          [100%] 1 of 1 ✔
Completed at: 16-Aug-2024 16:27:21
Duration    : 1m 33s
CPU hours   : 0.1
Succeeded   : 84
```

To run the test using podman with ARM processor architecture (e.g., on a Mac with Apple silicon):

```console
$ cd rainbow_bridge-test
$ nextflow run -params-file single_demuxed.yml -profile podman_arm mhoban/rainbow_bridge -r main
 N E X T F L O W   ~  version 24.04.3

Pulling mhoban/rainbow_bridge ...
 downloaded from https://github.com/mhoban/rainbow_bridge.git
WARN: It appears you have never run this project before -- Option `-resume` is ignored
Launching `https://github.com/mhoban/rainbow_bridge` [tiny_wright] DSL2 - revision: a160ca1ad5 [main]

executor >  local (84)
[-        ] process > unzip                 -
[95/f43afb] process > filter_merge (19)     [100%] 19 of 19 ✔
[6b/560f50] process > ngsfilter (19)        [100%] 19 of 19 ✔
[a6/5d4824] process > filter_length (19)    [100%] 19 of 19 ✔
...
...
...
```
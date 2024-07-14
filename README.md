# Test data for the `rainbow_bridge` metabarcoding pipeline.

This repository contains data that you can use to test your installation of the [rainbow_bridge](https://github.com/mhoban/rainbow_bridge) metabarcoding pipeline. Here you will find test datasets for each of the possible input scenarios supported by `rainbow_bridge`:

* Single-end sequencing runs
  * Demultiplexed
  * Undemultiplexed
* Paired-end sequencing runs
  * Demultiplexed
  * Undemultiplexed

The pipeline assumes that for undemultiplexed datasets you have used barcoded primers (see [obitools](https://pythonhosted.org/OBITools/scripts/ngsfilter.html) documentation for more info) and for demultiplexed datasets, your samples were separated using Illumina indices (for more information, see the README for `rainbow_bridge`). 

To test the pipeline, run one of the several test shell scripts in the repository. The script names should be self-explanatory (e.g., `test_paired_demuxed.sh`, `test_single_undemuxed.sh`). Your system will need to have `rainbow_bridge`'s dependencies installed (see the `rainbow_bridge` README for information). If you have cloned the `rainbow_bridge` repository and added it to your system PATH, the test scripts will use that version. If no executable instance of `rainbow_bridge.nf` is found in the PATH, the test scripts will run `rainbow_bridge` using netflow's built-in [github support](https://www.nextflow.io/docs/latest/sharing.html#running-a-pipeline) (in which case, the pipeline will be cloned to `$HOME/.nextflow/assets`). 

To run the scripts, open a terminal, change into the repository directory, and run the appropriate script. You can see how the pipeline is invoked (i.e., which options are used) by viewing the contents of the test scripts. Each example uses a custom BLAST database to save processing time. Taxonomy has been arbitrarily assigned to the test zOTU sequences in these databases, so if you try to query them against the actual NCBI database, you'll probably get different results. 

By default, the test scripts will use the singularity version of the pipeline. If you wish to use podman (or a different user-defined profile), simply pass a profile name as an argument to the test script. If you include no arguments, the default (standard) profile will be used.

Here is a worked example including the sort of output you should expect to see:

```console
$ cd rainbow_bridge-test
$ ./test_paired_demuxed.sh
N E X T F L O W  ~  version 24.01.0-edge
WARN: It appears you have never run this project before -- Option `-resume` is ignored
Launching `../../rainbow_bridge.nf` [friendly_euler] DSL2 - revision: 8464fa0b9e
executor >  local (56)
[85/6dd3f2] process > unzip (2)             [100%] 8 of 8 ✔
[99/aae470] process > remap_samples (8)     [100%] 8 of 8 ✔
[3e/082a18] process > filter_merge (8)      [100%] 8 of 8 ✔
[43/06f139] process > ngsfilter (8)         [100%] 8 of 8 ✔
[01/c9eb63] process > filter_length (5)     [100%] 8 of 8 ✔
[46/cd5b03] process > relabel_vsearch (8)   [100%] 8 of 8 ✔
[80/12aa45] process > derep_vsearch (1)     [100%] 1 of 1 ✔
[2d/0c1659] process > get_taxdb             [100%] 1 of 1 ✔
[c4/6d1f7c] process > blast (1)             [100%] 1 of 1 ✔
[ee/8f5493] process > lulu_blast (1)        [100%] 1 of 1 ✔
[3d/e256fb] process > lulu (1)              [100%] 1 of 1 ✔
[96/5225b5] process > get_lineage           [100%] 1 of 1 ✔
[4c/52b0f2] process > collapse_taxonomy (1) [100%] 1 of 1 ✔
[de/6a9ce7] process > finalize (1)          [100%] 1 of 1 ✔


$ ls -l paired_test_demux/
total 8
drwxrwxr-x 1 mykle mykle    0 Mar 20 11:54 output/
drwxrwxr-x 1 mykle mykle    0 Mar 20 11:53 preprocess/
drwxrwxr-x 1 mykle mykle 8192 Mar 20 11:53 work/
```

To run the test using podman with ARM processor architecture (e.g., Mac with Apple silicon):

```console
$ cd rainbow_bridge-test
$ ./test_paired_demuxed.sh podman_arm
N E X T F L O W  ~  version 24.01.0-edge
WARN: It appears you have never run this project before -- Option `-resume` is ignored
Launching `../../rainbow_bridge.nf` [friendly_euler] DSL2 - revision: 8464fa0b9e
executor >  local (56)
[85/6dd3f2] process > unzip (2)             [100%] 8 of 8 ✔
[99/aae470] process > remap_samples (8)     [100%] 8 of 8 ✔
[3e/082a18] process > filter_merge (8)      [100%] 8 of 8 ✔
[43/06f139] process > ngsfilter (8)         [100%] 8 of 8 ✔
...
```
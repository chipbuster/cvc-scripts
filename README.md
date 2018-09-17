# Nathan's CVC Scripts #
Here are some cool scripts I've found useful. I've tried to make them usable on
many different platforms by creating a Makefile.def file that houses all the
paths for various files and folders. Inside this file you'll also find some
paths that currently work on Stampede. You should just be able to change the
paths inside this file and it should work across all the scripts.

You can use Makefile.def.stampede for stampede or Makefile.def.lonestar for either
machine.

Run
```bash
make
```
to compile a few programs, and also check the environment for the existence of
necessary ones.

## Note to Disgruntled User ##
Please note: if you should choose to copy/move one of these scripts into a
different folder, you should know that the script will likely break. Most of
these are meant to be run from another folder. Something like:

```bash
export SCRIPT_DIR=/path/to/script/dir
$SCRIPT_DIR/getTotalEnergy.sh protein.pdb
```

In addition, many of the scripts are not well-suited for running from a folder
other than the folder the input is in. This includes things like runSingles,
runAmber, etc.

## Minimum Required Programs for Protein Docking

In order to run docking protocols, you will need at minimum for the following
programs to be valid in `Makefile.def`:

  - MolSurf
  - MolEnergy (or GPUEnergy, but stick with MolEnergy unless you like cursing the compiler)
  - F2Dock\_refactored
  - PDB2PQR
  - TMAlign
  - SCWRL4
  - PyMol
  - OBabel

In particular, you do not need MGLTools--any indication from the program that
you do indicated that you probably compiled the wrong version or with the wrong
flags.

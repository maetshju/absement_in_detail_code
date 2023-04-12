[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.7823844.svg)](https://doi.org/10.5281/zenodo.7823844)

# Absement in detail

Code associated with the "Absement in detail" paper, accepted for presentation at ICPhS 2023.

## Setting up the Julia environment

This set of code was run with Julia 1.8.5. It is possible that other versions can be used to reproduce the results and analysis, but for posterity, I have included both the "Manifest.toml" file and indicated exact versions in the [compat] section of the "Project.toml" file. To make more liberal use of packages, the compat section in the "Project.toml" file can be relaxed by removing the "=" sign in each of the version specifiers. The "Manifest.toml" file would also need to be removed.

To set up the environment:

1. Start Julia in the directory for this repo.
2. Run `] activate`
3. Run `] instantiate`

Alternatively, run the following command in the command line while in the directory for this repo:

```bash
julia -e "using Pkg; Pkg.activate(); Pkg.instantiate"
```

## Running the code

The code files have been numbered with the order they should be executed in. When they output simple text files, I have kept those in the repo.

## Obtaining the data

The files for the sR speaker can be obtained from [the current release of the MALD data set](https://nascl.rc.nau.edu/resources/massive-auditory-lexical-decision/) on the [University of Alberta Education and Research Archive](https://doi.org/10.7939/r3-v0jr-rr12). The other two speakers have not yet been released to the public, but they are intended to be at some point in the future. These recordings will need to be placed in three folders within this repo: a folder called `sR`, a folder called `sK`, and a folder called `sJ`.

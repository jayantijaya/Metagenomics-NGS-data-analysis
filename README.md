# Metagenome Pipeline README

## Overview
This is a fully reproducible metagenome analysis pipeline. It automates steps from quality control of raw sequencing reads to taxonomic binning using MEGAN.

The pipeline performs the following steps:
1. Quality control using **FastQC**
2. Adapter trimming and read filtering using **Trimmomatic**
3. Sequence alignment to protein databases using **DIAMOND**
4. Conversion of SAM files to RMA files using **MEGAN tools** for taxonomic analysis

## Requirements
The pipeline requires the following software:
- Bash (version >= 5.1)
- FastQC (version 0.11.9)
- Trimmomatic (version 0.32)
- DIAMOND (version 2.0.15)
- MEGAN tools (version 6.21.10)
- Java (version 1.8)

Dependencies can be listed in `requirements.txt` for reference.

## Input
- Paired-end metagenomic FASTQ files with filenames in the format `sample_R1_001.fastq` and `sample_R2_001.fastq`.

## Usage
1. Place all FASTQ files in a single directory.
2. Modify paths in `metagenome_pipeline.sh` to match your local installation paths for FastQC, Trimmomatic, DIAMOND, and MEGAN tools.
3. Run the pipeline:

```bash
bash metagenome_pipeline.sh
```

The pipeline will create separate directories for each sample and generate the following output:
- FastQC quality reports
- Trimmed reads
- DIAMOND output (`.daa` and `.sam` files)
- RMA files for MEGAN taxonomic analysis

## Output
For each sample, a directory is created containing:
- QC reports from FastQC
- Trimmed FASTQ files
- DIAMOND output (`.daa` and `.sam`)
- MEGAN `.rma` files

The final combined results can be used for downstream taxonomic and functional analysis in MEGAN.

## Notes
- Ensure sufficient computational resources for DIAMOND alignments and MEGAN processing.
- The pipeline assumes the presence of a DIAMOND NR database and MEGAN GI-to-TaxID mapping file.

## License
This pipeline is released under the GNU-GPL License. See `LICENSE` file for details.

## Author
**Jayanthi Jayakumar**
- Email: jayantijayakumar@gmail.com

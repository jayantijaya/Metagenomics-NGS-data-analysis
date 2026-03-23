#!/bin/bash
############Metagenome pipeline from Qualting checking to Taxonomic Binning of reads#### Jayanthi Jayakumar#####
for i in `ls *.fastq | cut -f 1 -d "." | cut -f 1,2,3 -d "_" | sort -u`
    do
echo $i
mkdir $i
#####------TO RUN FASTQC---------######################################
/home/gmsjaya/bio/NGS/VirMetaTrans/FastQC/./fastqc $i\_R1_001.fastq
/home/gmsjaya/bio/NGS/VirMetaTrans/FastQC/./fastqc $i\_R2_001.fastq
unzip  `echo $i\_R1_001.fastq  | cut -f 1 -d "."`_fastqc
unzip  `echo $i\_R2_001.fastq  | cut -f 1 -d "."`_fastqc
name=$(grep ">>Basic" /home/gmsjaya/bio/NGS/VirMetaTrans/`echo $i\_R1_001.fastq  | cut -f 1 -d "."`_fastqc/fastqc_data.txt)
name2=$(grep ">>Basic" /home/gmsjaya/bio/NGS/VirMetaTrans/`echo $i\_R2_001.fastq  | cut -f 1 -d "."`_fastqc/fastqc_data.txt)
echo "Fastqc for" $i\_R1_001.fastq ":" $name >> fastqc_check.txt;
echo "Fastqc for" $i\_R2_001.fastq ":" $name2 >> fastqc_check.txt;

#####------TO RUN TRIMMOMATIC-----######################################
java -jar trimmomatic-0.32.jar PE $i\_R1_001.fastq $i\_R2_001.fastq $i/fwd_p.$i.fastq $i/fwd_up.$i.fastq $i/rw_p.$i.fastq $i/rw_up.$i.fastq ILLUMINACLIP:TruSeq2-PE.fa:2:30:10 LEADING:10 TRAILING:10 SLIDINGWINDOW:4:20 MINLEN:50
cd $i
 for file in *.fastq
   do
     echo $file
#####------RUN DIAMOND-----------#######################################
/home/gmsjaya/bio/NGS/diamond/bin/./diamond blastx -d /home/gmsjaya/bio/NGS/Diamond_db/nr.dmnd -q $file  -a $file.daa -t /gpfs/public/  -o $file.out
/home/gmsjaya/bio/NGS/diamond/bin/./diamond view -a  $file.daa  -o $file.sam -f sam --compress 1

    done
for k in *.gz


   do
      echo $k
#######------RUN SAM2RMA--------########################################
/home/gmsjaya/bio/NGS/MEGAN/megan/tools/./sam2rma -i $k -o $k.rma3 -g2t /home/gmsjaya/bio/NGS/MEGAN/Taxonmap/gi_taxid-March2015X.bin
    done
done

#!/usr/bin/bash

set -e
echo -e "\e[31;91m `date` \e[0m";
start_time=$(date +%s)

# prepare software path
bwa="/hpcdata/yangld/00.project/wangcheng/software/bwa-0.7.17/bwa"  #The bwa must the lastest version
samtools="/hpcdata/yangld/00.project/wangcheng/software/samtools-1.16.1/samtools"
export PATH=/hpcdata/yangld/00.project/wangcheng/software/bwa-0.7.17/:$PATH
export PATH=/hpcdata/yangld/00.project/wangcheng/software/samtools-1.16.1/:$PATH
trimmatic="/hpcdata/yangld/00.project/wangcheng/software/Trimmomatic-0.39/trimmomatic-0.39.jar"
fastqc="/hpcdata/yangld/00.project/wangcheng/software/FastQC/fastqc"
enzyme="/hpcdata/yangld/00.project/wangcheng/software/juicer-1.6/misc/generate_site_positions.py"
#####################################################################
wk=`pwd`
genome=$1  #full path genome
hicReads1=$2  # full path Reads
hicReads2=$3 # full path Reads
mode=$4  # MboI / HindIII / DpnII / Sau3AI / Arima
###################################################
if [ $# -lt 4 ];then
	echo -e "Please check your argument\n";
	echo -e "bash $0 [Full path genome] [Full path hicReads1] [Full path hicReads2] [MboI / HindIII / DpnII / Sau3AI / Arima]!\n";

else
	if [ ! -e "$wk/1.ref/index_done" ];then
		mkdir -p $wk/1.ref && cd $wk/1.ref
		echo -e "Bwa index genome\n";
		ln -s $genome genome.fa
		$bwa index genome.fa
		echo -e "bwa index Was Done!\n";
		echo -e "Now get the contig genome length file!\n";
		$samtools faidx genome.fa
		awk '{print $1"\t"$2}' genome.fa.fai >genome.fa.len
		touch "$wk/1.ref/index_done";
		echo -e "This step ALL DONE!!!\n";
	fi
	
	if [ ! -e "$wk/1.ref/site_done" ];then
		cd $wk/1.ref
		echo -e "Now get the enzyme splicing file!\n";
		python2 $enzyme $mode genome genome.fa
		touch "$wk/1.ref/site_done"
		echo -e "Enztme splicing file Done!\n";
	fi
	
	if [ ! -e "$wk/2.juicer/fastq/fastq_done" ];then
		mkdir -p $wk/2.juicer/fastq && cd $wk/2.juicer/fastq
		ln -s $hicReads1 .
		ln -s $hicReads2 .
		echo -e "Now trim the raw hic fastq files\n";
		java -jar $trimmatic PE -threads 30 -validatePairs $hicReads1 $hicReads2 ILLUMINACLIP:/hpcdata/yangld/00.project/wangcheng/software/Trimmomatic-0.39/adapters/TruSeq3-PE-2.fa:2:30:10:8:true LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:50 -baseout $wk/2.juicer/fastq/pop_clean.fastq.gz
		echo -e "The trimmatic Was Done!\n";
		$fastqc -t 30 pop_clean_1P.fastq.gz pop_clean_2P.fastq.gz -o ./
		echo -e "The fastQC Was Done\n";
		mv pop_clean_1P.fastq.gz hic_R1.fastq.gz
		mv pop_clean_2P.fastq.gz hic_R2.fastq.gz
		touch "$wk/2.juicer/fastq/fastq_done"
		echo -e "Fastq file was DONE!!!\n";
	fi

	if [ ! -e "$wk/2.juicer/juicer_done" ];then
		cd $wk/2.juicer/
		/hpcdata/yangld/00.project/wangcheng/software/juicer-1.6/scripts/juicer.sh -g genome -d $wk/2.juicer -s $mode -S early -p $wk/1.ref/genome.fa.len -y $wk/1.ref/genome_${mode}.txt -z $wk/1.ref/genome.fa -D /hpcdata/yangld/00.project/wangcheng/software/juicer-1.6/scripts -t 30
		touch "$wk/2.juicer/juicer_done"
		echo -e "Juicer Was Done\n";

	fi

	if [ ! -e "$wk/3.3d-dna/done" ];then
		mkdir -p $wk/3.3d-dna && cd $wk/3.3d-dna
		mkdir -p tempdir
		export TMPDIR="./tempdir"
		/hpcdata/yangld/00.project/wangcheng/software/3d-dna/run-asm-pipeline.sh $wk/1.ref/genome.fa $wk/2.juicer/aligned/merged_nodups.txt
		touch "$wk/3.3d-dna/done"
		echo -e "The 3d-dna Was Done!!!\n";
	fi

fi

end_time=$(date +%s)
consume_time=$[ $end_time-$start_time ]
echo -e "\e[32;92m The program consumed time is $(($consume_time/60))min $(($consume_time%60))s!!! \e[0m"
echo -e "\e[31;91m `date` \e[0m";



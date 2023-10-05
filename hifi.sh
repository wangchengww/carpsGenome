#!/usr/bin/bash

date

samtools=/hpcdata/clad/wangcheng/biosoft/samtools/samtools-1.9/samtools
hifiasm=/hpcdata/yangld/02.software/hifiasm-0.18.5/hifiasm

bamreads=$1
wk=`pwd`
start_time=$(date +%s)

if [ $# -lt 1 ];then
	echo -e "Please check your argument!\n";
	echo -e "bash $0 [Hifi reads.bam]\n";
else
	if [ ! -e "$wk/hifiDone" ];then

	echo -e "First to transfer hifi bam files to fq.gz\n";
	$samtools bam2fq  -@ 20 $bamreads |gzip - >hifi.fq.gz

	echo -e "Then use hifiasm assembly\n";
	$hifiasm -o hifi.asm -t 20 hifi.fq.gz 1>hifiasm.log 2>hifiasm.err
	awk '/^S/{print ">"$2;print $3}' hifi.asm.bp.p_ctg.gfa > hifi.asm.fasta
	echo -e "Hifiasm assembly  was done!!\n"
	touch "$wk/hifiDone"
	fi
fi

end_time=$(date +%s)
cost_time=$[ $end_time-$start_time ]
echo "This hifiasm  assembly program used time is: $(($cost_time/60))min $(($cost_time%60))s"


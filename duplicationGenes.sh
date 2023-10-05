# Analysis of duplicated genes.
# self-balstp in each species of protein gene seqs 1e-5 to 1e-50
# cluster with mcl. mul(0.4343),ceil(200)
https://www.jianshu.com/p/146093c91e2b
#
/hpcdata/clad/wangcheng/WorkSpace/Project_Four_major_Chinese_carps/Published_data/Analysis/4fish_genefamily/gene_duplication/
#
makeblastdb -in An.pep -dbtype prot -out An
blastp -num_threads 20 -db An -query An.pep -outfmt 7 -seg yes -evalue 1e-5 >blast.out.txt  #-seg参数过滤低复杂度的序列(即氨基酸编码为X),

grep -v "#"  blast.out.txt | cut -f 1,2,11 > blast_output.abc
/hpcdata/clad/wangcheng/biosoft/mcl/mcl-14-137/bin/mcxload -abc blast_output.abc --stream-mirror --stream-neg-log10 -stream-tf 'mul(0.4343),ceil(200)' -o blast_output.mci -write-tab blast_output.tab
/hpcdata/clad/wangcheng/biosoft/mcl/mcl-14-137/bin/mcl blast_output.mci -I 3
/hpcdata/clad/wangcheng/biosoft/mcl/mcl-14-137/bin/mcxdump -icl out.blast_output.mci.I30 -tabr blast_output.tab -o dump.blast_output.mci.I30

cat dump.blast_output.mci.I30 |perl -alne '@tmp = split/\s+/; print scalar(@tmp);' >dupgenenumber1
python3 1.py dupgenenumber1  >An.duplicat_gene.stat.txt
##########################################################
# Tandem duplication: located on the same scaffold within 10kb
# Intrachromosomal duplication (non-duplication): located on different scaffolds but on the same chromosomes
# Interchromosomal duplications: located on different chromosomes.
les An.gff |grep "gene"  |awk -F ";"  '{print $1}'|awk '{print $1"\t"$4"\t"$5"\t"$9}' |sed 's/ID=//g' >An.gene.bed
grep -v "Contig" An.gene.bed  >t
mv t An.gene.bed
#
python3 3.py An.gene.bed   dump.blast_output.mci.I30 >duplicated.type.txt

les duplicated.type.txt |grep "Interchromosome" |wc -l
les duplicated.type.txt |grep "Intrachromosome" |wc -l
les duplicated.type.txt |grep "Tandem" |wc -l
##########################################
python3 4.py Mp.gene.bed tandem.dup.txt  # extract gene ID

len <- c(19.57,19.09,18.61,17.45,17.17,16.00,13.77,13.54,13.02,13.01,12.55,12.27,12.18,11.74,11.64,11.50,11.49,10.68,10.59,10.38,9.87,9.67,9.49,8.64)
length(len)
id <- c(1:24)
id
ids <- paste("contig",id,sep = "")
da <- data.frame(id = ids,len = len)

library(treemap)

dev.new()
treemap(da,index = "id",vSize = "len",
        vColor = "len",type="dens",format.legend = list(scientific = FALSE, big.mark = " "),
        lab = F)
library(ggplot2)
library(treemapify)
ggplot(da, aes(area = len,fill = len)) +
  geom_treemap(color = "white") + scale_fill_gradientn(colours = c("#a73123","white","#006838"))

################################################
clen <- c(24.33,23.80,22.72,21.92,20.81,19.01,18.47,18.19,17.79,17.62,16.73,15.54,14.89,14.79,14.51,14.19,13.98)
cid <- paste("contig",1:17,sep = "")
cda <- data.frame(cid = cid,clen = clen)
ggplot(cda, aes(area = clen,fill = clen)) +
  geom_treemap(color = "white") + scale_fill_gradientn(colours = c("white","#006838"))


 ###########################################
rm(list = ls())
graphics.off()
library(ggplot2)
library(RColorBrewer)
#devtools::install_github("wilkox/treemapify")
#install.packages("treemap")
library(treemapify)
library(treemap)

theme <- theme_bw()+
  theme(plot.title = element_text(hjust = 0.5),
        panel.background = element_rect(fill = 'white', colour = 'black'),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

md = read.table('genome.contig_gap.block.bed', h=F)
md$V1 <- factor(md$V1)
head(md)
md <- md[md$V5=="contig",]
md <- md[grepl("chr",md$V1),]
#min(md$V4);max(md$V4)

md <- md[md$V1=="chr1" | md$V1=="chr2" | md$V1=="chr3" | md$V1=="chr4" | md$V1=="chr5"
         | md$V1=="chr6" | md$V1=="chr7" | md$V1=="chr8" | md$V1=="chr9" | md$V1=="chr10" | md$V1=="chr11" | md$V1=="chr12" | md$V1=="chr13" | md$V1=="chr14" | md$V1=="chr15" | md$V1=="chr16" | md$V1=="chr17" | md$V1=="chr18" | md$V1=="chr19" | md$V1=="chr20" | md$V1=="chr21" | md$V1=="chr22" | md$V1=="chr23" | md$V1=="chr24",]
p1 <- ggplot(md, aes(area=V4, label=V1, subgroup = V1))+
  geom_treemap(colour="Black",fill="White")+
  # geom_treemap_text(fontface = "italic", colour = "white", place = "centre",
  #                   grow = TRUE)+
  geom_treemap_subgroup_border()+
  geom_treemap_subgroup_text(place = "centre", grow = T, alpha = 0.9, colour =
                               "Black", fontface = "italic", min.size = 0)

#pdf("p1.pdf",width = 10, height = 10)
p1
#dev.off()
#####################

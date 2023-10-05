rm(list = ls())
library(ggplot2)
library(tidyverse)

species <- c("Callorhinchus_milii","Polyodon_spathula","Atractosteus_spatula","Scleropages_formosus",
             "Alosa_sapidissima","Chanos_chanos","Carassius auratus","Aristichthys_nobilis","Hypophthalmichthys_molitrix",
             "Ctenopharyngodon_idella","Mylopharyngodon_piceus",
             "Danio_rerio"
             )
#total_len <- c(1063011607,991535955,2931599576,3556477427,945878036,893890919,913249663,854783385,909925056,1373471384)

DNA <- c(0.6,17.22,3.95,11.16,20.35,7.86,16.38,30.3,28.62,30.06,31.1,34.3)

LINE <- c(12.6,14.51,6.5,16.36,6.42,2.15,4.5,3.24,2.93,3.05,3.02,2.83)

SINE <- c(13.1,0.3,3.55,2.08,0.88,0.3,0.47,0.6,0.56,0.2,0.47,2.34)

LTR <- c(0.4,9.09,9.89,12.33,2.06,1.92,4.89,5,4.4,5.11,4.67,5.07)

exon <- c(3.06,3.47,2.73,5.46,5.13,6.36,4.91,4.49,4.72,4.55,4.66,2.39)

intron <- c(42.97,40.14,32.8,41.84,46.4,40.65,39.9,42.16,46.39,44.95,46.43,37.45)

Other <- c(25.23,15.27,39.85,10.48,9.21,38.06,22.07,7.25,5.73,4.89,2.44,15.28)

unclassified <- c(2.3,0,0.73,0.29,9.55,2.7,6.88,6.96,6.65,7.19,7.21,0.34)

genome_size <- c(991535955,1542083420,1055216122,784563014,903581644,656929047,1820635050,909925056,854783385,913249663,893890919,1679203469)

df <- data.frame(species = species,DNA = DNA,LINE = LINE,SINE = SINE,LTR = LTR,Other = Other,exon=exon,intron=intron,
                 unclassified = unclassified)
head(df)
#df$species <- factor(df$species,levels = c("Aristichthys_nobilis","Hypophthalmichthys_molitrix","Ctenopharyngodon_idella",
                                          "Mylopharyngodon_piceus","Carassius auratus", "Danio_rerio", "Chanos_chanos",
                                         "Alosa_sapidissima", "Scleropages_formosus","Atractosteus_spatula","Polyodon_spathula",
                                         "Callorhinchus_milii"))





#tmp$group <- factor(tmp$group,levels = c("Other","DNA","LINE","LTR","SINE"))
tmp <- df %>% gather(group, abundance, -species)
head(tmp)
tmp$species <- factor(tmp$species,levels = c("Callorhinchus_milii","Polyodon_spathula","Atractosteus_spatula", "Scleropages_formosus","Alosa_sapidissima",
                                             "Chanos_chanos","Danio_rerio","Carassius auratus", "Mylopharyngodon_piceus",
                                             "Ctenopharyngodon_idella","Hypophthalmichthys_molitrix","Aristichthys_nobilis"))
tmp$group <- factor(tmp$group,levels = c("Other","unclassified","intron","exon","SINE","LTR","LINE","DNA"))

 ggplot(tmp,aes(x = species,y = abundance,fill = group)) +
  geom_bar(stat = "identity",width = 0.5) +
  theme_classic() + 
  coord_flip() + 
  scale_fill_manual(values =  c("#89adc7","#d37d54","#9da384","#cda767","#78a29a","#92898d",
                                "#4a7294","#c9be98")) +
   theme(axis.text = element_text(size = 12,color = "black",face = "bold"),
         axis.line = element_line(size = 1),
         axis.ticks = element_line(size = 1)) +
   labs(x="",y="")
####################################################

gs <- data.frame(gsize= genome_size,sp = species)
head(gs)
gs$sp <- factor(gs$sp,levels = c("Callorhinchus_milii","Polyodon_spathula","Atractosteus_spatula", "Scleropages_formosus","Alosa_sapidissima",
                                             "Chanos_chanos","Danio_rerio","Carassius auratus", "Mylopharyngodon_piceus",
                                             "Ctenopharyngodon_idella","Hypophthalmichthys_molitrix","Aristichthys_nobilis"))

ggplot(gs,aes(x=sp,y = gsize)) + geom_point(data = gs,pch = 21,aes(size = x +20),col = "grey20") 
head(gs)
gs
gs$x <- c(80,100,90,20,50,10,120,60,30,70,40,110)

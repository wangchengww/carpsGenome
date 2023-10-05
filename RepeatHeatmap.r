rm(list = ls())
#install.packages("xlsx")
library(ggplot2)
library(readxl)
#---------------
data <- readxl::read_xlsx("Repeat.xlsx",sheet=1)
head(data)
typeof(data)
class(data)


#---------------------------------------------
library(pheatmap)
pheatmap(mtr1,scale = "row",cluster_rows = F,cluster_cols = F,
         clustering_distance_rows = "correlation",
         cellwidth = 50,cellheight = 8,fontsize = 8,
         main = "Rpeat Type of Four fishes",
         color = colorRampPalette(c("#3288bd","#ffffbf","#d53e4f"))(100))
#-------------------------------------
pheatmap(mtr1, scale = "row",
         cluster_rows = F,cluster_cols = F,
         cellwidth = 50,cellheight = 8,fontsize = 8,
         display_numbers = matrix(ifelse(mtr1 > 2, "*", ""), nrow(mtr1)),
         color = colorRampPalette(c("blue","white","red"))(100),
         )
#====================================================
tail(mtr1)
#######################
mtr2 <- as.matrix(data[,-1])
head(mtr2)
colnames(mtr2)  
rownames(mtr2) <- c("Satellite","Unknown","Simple_repeat","SINE","Retroposon","ACADEM","CMC-CHAPAEV","CMC-ENSPM","CRYPTON",
"CRYPTON-A", "CRYPTON-H","CRYPTON-V", "DADA","GINGER","HAT","HAT-AC","HAT-BLACKJACK","HAT-CHARLIE","HAT-HAT5","HAT-HAT6",
"HAT-HOBO","HAT-HATM","HAT-TAG1","HAT-TIP100","HAT-TOL2","IS3EU","KOLOBOK","KOLOBOK-T2","MAVERICK", "MERLIN", 
"MULE-MUDR","MULE-NOF","P","PIF","PIF-HARBING","PIF-HARBINGER","PIF-ISL2EU","PIGGYBAC","SOLA","SOLA-1","SOLA-2","TCMAR","TCMAR-FOT1","TCMAR-ISRM11","TCMAR-STOWAWAY","TCMAR-MARIN","TCMAR-MARINER","TCMAR-TC1","TCMAR-TC2","TCMAR-TIGGER","ZATOR","ZISUPTON","L1","L2","Copia","Gypsy")
dimnames(mtr2)
dim(mtr2)
head(mtr2)
heatmap(mtr2)

pheatmap(mtr2,scale = "row",cluster_rows = F,cluster_cols = F,
         color = colorRampPalette(c("navy", "white", "firebrick3"))(50),
         cellwidth = 50,cellheight = 8,fontsize = 8,)
#------------------------------
data_subset_norm <- t(apply(mtr2,1,cal_z_score))
head(data_subset_norm)
pheatmap(data_subset_norm,cluster_rows = F,cluster_cols = F,
         display_numbers = matrix(ifelse(data_subset_norm >3 , "***", ""),nrow(data_subset_norm)),
         color = colorRampPalette(colors = c("#313695","#e0f3f8","red"))(100),
         cellwidth = 10,cellheight = 6,fontsize = 6)
####################################################################
An <- read_xlsx("An.24total.xlsx",sheet = 1)
head(An)
An1 <- as.matrix(An[,-1])
head(An1)
rownames(An1) <- c("DNA_ACADEM-1", "DNA_CMC-CHAPAEV-3", "DNA_CMC-ENSPM", "DNA_CRYPTON", 
                   "DNA_CRYPTON-A", "DNA_CRYPTON-H", "DNA_CRYPTON-V", "DNA_DADA", "DNA_GINGER-1", 
                   "DNA_HAT", "DNA_HAT-AC", "DNA_HAT-BLACKJACK", "DNA_HAT-CHARLIE", "DNA_HAT-HAT5",
                   "DNA_HAT-HAT6", "DNA_HAT-HOBO", "DNA_HAT-TAG1", "DNA_HAT-TIP100", "DNA_HAT-TOL2",
                   "DNA_IS3EU", "DNA_KOLOBOK", "DNA_KOLOBOK-T2", "DNA_MAVERICK", "DNA_MERLIN", 
                   "DNA_MULE-MUDR", "DNA_MULE-NOF", "DNA_P", "DNA_PIF", "DNA_PIF-HARBING", "DNA_PIF-HARBINGER",
                   "DNA_PIF-ISL2EU", "DNA_PIGGYBAC", "DNA_SOLA-1", "DNA_SOLA-2", "DNA_TCMAR", "DNA_TCMAR-FOT1",
                   "DNA_TCMAR-ISRM11", "DNA_TCMAR-STOWAWAY", "DNA_TCMAR-TC1", "DNA_TCMAR-TC2", "DNA_TCMAR-TIGGER",
                   "DNA_ZATOR", "DNA_ZISUPTON", "LINE_L1", "LINE_L2", "LTR_Copia", "LTR_Gypsy", "Retroposon", 
                   "SINE", "Satellite", "Simple_repeat", "Unknown")
colnames(An1) <- c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24)
dimnames(An1)

#------------------------------------------------------------------------------
cal_z_score <- function(x){
  (x - mean(x)) / sd(x)
}

An_data_subset_norm <- t(apply(An1,1,cal_z_score))
head(An_data_subset_norm)
Anmap <- pheatmap(An_data_subset_norm,cluster_rows = F,cluster_cols = F,
         display_numbers = matrix(ifelse(An_data_subset_norm >3 , "***", ""),nrow(An_data_subset_norm)),
         color = colorRampPalette(colors = c("#313695","#e0f3f8","red"))(100),
         cellwidth = 10,cellheight = 6,fontsize = 6)
#-------------------------------------------------------------------------------------
Ci <- read_xlsx("Ci.24total.xlsx",sheet = 1)
head(Ci)
Ci1 <- as.matrix(Ci[,-1])
head(Ci1)
c <- as.character(Ci[,1])
c
rownames(Ci1) <- c("DNA_ACADEM-1","DNA_CMC-CHAPAEV-3","DNA_CMC-ENSPM","DNA_CRYPTON","DNA_CRYPTON-A",  "DNA_CRYPTON-H","DNA_CRYPTON-V",  "DNA_DADA",  "DNA_GINGER-1",  "DNA_HAT",  "DNA_HAT-AC",  "DNA_HAT-BLACKJACK",  "DNA_HAT-CHARLIE",  "DNA_HAT-HAT5",  "DNA_HAT-HAT6",  "DNA_HAT-HATM",  "DNA_HAT-HOBO",  "DNA_HAT-TAG1",  "DNA_HAT-TIP100",  "DNA_IS3EU",  "DNA_KOLOBOK",  "DNA_KOLOBOK-T2",  "DNA_MAVERICK",  "DNA_MERLIN",  "DNA_MULE-MUDR",  "DNA_MULE-NOF",  "DNA_P",  "DNA_PIF",  "DNA_PIF-HARBINGER",  "DNA_PIF-ISL2EU",  "DNA_PIGGYBAC",  "DNA_SOLA","DNA_SOLA-1",  "DNA_SOLA-2",  "DNA_TCMAR",  "DNA_TCMAR-FOT1",  "DNA_TCMAR-ISRM11",  "DNA_TCMAR-STOWAWAY",  "DNA_TCMAR-TC1",  "DNA_TCMAR-TC2",  "DNA_TCMAR-TIGGER",  "DNA_ZATOR",  "DNA_ZISUPTON",  "LINE_L1",  "LINE_L2",  "LTR_Copia",  "LTR_Gypsy",  "Retroposon",  "SINE",  "Satellite",  "Simple_repeat",  "Unknown")
colnames(Ci1) <- c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24)
dimnames(Ci1)
Ci_data_subset_norm <- t(apply(Ci1,1,cal_z_score))
head(Ci_data_subset_norm)
Cimap <- pheatmap(Ci_data_subset_norm,cluster_rows = F,cluster_cols = F,
         display_numbers = matrix(ifelse(Ci_data_subset_norm >3 , "***", ""),nrow(Ci_data_subset_norm)),
         color = colorRampPalette(colors = c("#313695","#e0f3f8","red"))(100),
         cellwidth = 10,cellheight = 6,fontsize = 6)


#-------------------
Hm <- read_xlsx("Hm.24total.xlsx",sheet = 1)
head(Hm)
Hm1 <- as.matrix(Hm[,-1])
head(Hm1)
h <- as.character(Hm[,1])
h
rownames(Hm1) <- c("DNA_ACADEM-1", "DNA_CMC-CHAPAEV-3", "DNA_CMC-ENSPM", "DNA_CRYPTON", "DNA_CRYPTON-A", "DNA_CRYPTON-H", "DNA_CRYPTON-V", "DNA_DADA", "DNA_GINGER-1", "DNA_HAT", "DNA_HAT-AC", "DNA_HAT-BLACKJACK", "DNA_HAT-CHARLIE", "DNA_HAT-HAT5", "DNA_HAT-HAT6", "DNA_HAT-HOBO", "DNA_HAT-TAG1", "DNA_HAT-TIP100", "DNA_HAT-TOL2", "DNA_IS3EU", "DNA_KOLOBOK", "DNA_KOLOBOK-T2", "DNA_MAVERICK", "DNA_MERLIN", "DNA_MULE-MUDR", "DNA_MULE-NOF", "DNA_P", "DNA_PIF", "DNA_PIF-HARBINGER", "DNA_PIF-ISL2EU", "DNA_PIGGYBAC", "DNA_SOLA", "DNA_SOLA-1", "DNA_SOLA-2", "DNA_TCMAR", "DNA_TCMAR-FOT1", "DNA_TCMAR-ISRM11", "DNA_TCMAR-STOWAWAY", "DNA_TCMAR-TC1", "DNA_TCMAR-TC2", "DNA_TCMAR-TIGGER", "DNA_ZATOR", "DNA_ZISUPTON", "LINE_L1", "LINE_L2", "LTR_Copia", "LTR_Gypsy", "Retroposon", "SINE", "Satellite", "Simple_repeat", "Unknown")
colnames(Hm1) <- c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24)
dimnames(Hm1)
Hm_data_subset_norm <- t(apply(Hm1,1,cal_z_score))
head(Hm_data_subset_norm)
Hmmap <- pheatmap(Hm_data_subset_norm,cluster_rows = F,cluster_cols = F,
         display_numbers = matrix(ifelse(Hm_data_subset_norm >3 , "***", ""),nrow(Hm_data_subset_norm)),
         color = colorRampPalette(colors = c("#313695","#e0f3f8","red"))(100),
         cellwidth = 10,cellheight = 6,fontsize = 6)
#----------------------------------------------------
Mp <- read_xlsx("Mp.24total.xlsx",sheet = 1)
Mp1 <- as.matrix(Mp[,-1])
head(Mp1)
m <- as.character(Mp[,1])
m
rownames(Mp1) <- c("DNA_ACADEM-1", "DNA_CMC-CHAPAEV-3", "DNA_CMC-ENSPM", "DNA_CRYPTON", "DNA_CRYPTON-A", "DNA_CRYPTON-H", "DNA_CRYPTON-V", "DNA_DADA", "DNA_GINGER-1", "DNA_HAT", "DNA_HAT-AC", "DNA_HAT-BLACKJACK", "DNA_HAT-CHARLIE", "DNA_HAT-HAT5", "DNA_HAT-HAT6", "DNA_HAT-HOBO", "DNA_HAT-TAG1", "DNA_HAT-TIP100", "DNA_HAT-TOL2", "DNA_IS3EU", "DNA_KOLOBOK", "DNA_KOLOBOK-T2", "DNA_MAVERICK", "DNA_MERLIN", "DNA_MULE-MUDR", "DNA_MULE-NOF", "DNA_P", "DNA_PIF", "DNA_PIF-HARBINGER", "DNA_PIF-ISL2EU", "DNA_PIGGYBAC", "DNA_SOLA", "DNA_SOLA-1", "DNA_SOLA-2", "DNA_TCMAR", "DNA_TCMAR-FOT1", "DNA_TCMAR-ISRM11", "DNA_TCMAR-MARIN", "DNA_TCMAR-MARINER", "DNA_TCMAR-STOWAWAY", "DNA_TCMAR-TC1", "DNA_TCMAR-TC2", "DNA_TCMAR-TIGGER", "DNA_ZATOR", "DNA_ZISUPTON", "LINE_L1", "LINE_L2", "LTR_Copia", "LTR_Gypsy", "Retroposon", "SINE", "Satellite", "Simple_repeat", "Unknown")
colnames(Mp1) <- c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24)
dimnames(Mp1)
Mp_data_subset_norm <- t(apply(Mp1,1,cal_z_score))
head(Mp_data_subset_norm)
Mpmap <- pheatmap(Mp_data_subset_norm,cluster_rows = F,cluster_cols = F,
         display_numbers = matrix(ifelse(Mp_data_subset_norm >3 , "***", ""),nrow(Mp_data_subset_norm)),
         color = colorRampPalette(colors = c("#313695","#e0f3f8","red"))(100),
         cellwidth = 10,cellheight = 6,fontsize = 6)

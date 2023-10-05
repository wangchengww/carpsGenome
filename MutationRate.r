## mutation rate

rm(list = ls())

data <- read.table("Analysis/phylogeny/result.txt",header = F)
head(data)
barplot(data$V2/10e-9)

library(ggplot2)
library(ggchicklet)
library(dplyr)
library(forcats)
#data%>%mutate(name=fct_reorder(V1,desc(V2/10e-9))) 
#data %>%arrange(desc(V2/10e-9))
#data[order(data$V2),] %>%ggplot(aes(x = V1,y = V2/10e-9,fill = V1)) + geom_bar(stat = "identity")



cols <- c(rep("#878787",times=2),"#33a02c",rep("#878787",times=5),"#33a02c",rep("#878787",times=7),"#33a02c",
          "#878787","#33a02c",rep("#878787",times=8))

ggplot(data,aes(x = reorder(V1,-V2),y = V2/10e-9,fill = V1)) +
  geom_bar(stat = "identity") +
  #geom_chicklet() +
 
  theme_classic() + 
 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  scale_fill_manual(values = cols) +
  scale_y_continuous(limits = c(0,3),expand = c(0,0)) +
  theme(axis.title = element_text(size = 12,colour = "black",face = "bold")) +
  labs(y=paste("Mutation rate\n",expression(x10^-9),expression(site^-1),expression(y^r-1)),x="") +
  theme(axis.text = element_text(size = 10,colour = "black"),
          legend.position = "none")
 ###########################################

  

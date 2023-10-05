rm(list=ls())

library(ggplot2)

data <- data.frame(species = c("Hypophthalmichthys_nobilis(By Jian)","Hypophthalmichthys_nobilis(By Fu)",
                               "Hypophthalmichthys_molitrix(By Jian)","grass carp","Hypophthalmichthys_molitrix(By Zhou)",
                               "Mp","Ci","Hm","Hn"),
                   N50 = c(3.33,33.74,0.97,6.46,35,36.2,35.41,33.57,35.65),
                   busco = c(96.2,95.2,94.9,76.4,95,98.6,98.2,98.4,98.4))

head(data)

cols = c("#b2182b","#b2182b",
         "#1f78b4","#33a02c","#1f78b4",
         "#000000","#33a02c","#1f78b4","#b2182b")
ggplot(data,aes(x=N50,y=busco)) +
  #geom_point(aes(size = N50),color = "red")
  geom_point(size=5,color = cols,shape = c(20,20,19,21,19,17,21,19,20)) +
  ylim(c(50,100)) +
  xlim(c(0,50)) +
  labs(x="scaffold N50 (Mb)",y = "Busco (%)") +
  theme_classic() +
  theme(axis.title = element_text(size = 12,color = "black",face = "bold"),
        axis.text = element_text(size = 10,color = "black",face = "bold"))

library(karyoploteR)
Hm <- toGRanges("Analysis/seqdepth/Hm.chr.bed")
kp <- plotKaryotype(genome = Hm,plot.type=2,main = "Hypophthalmichthys molitrix")
Hmreg1 <- toGRanges("Analysis/seqdepth/Hm.hap1.delta.filter.coords.txt.bed")
Hmreg2 <- toGRanges("Analysis/seqdepth/Hm.hap2.delta.filter.coords.txt.bed")

kpPlotRegions(kp, data=Hmreg1, r0=0, r1=0.5, col = "#d73027",  lwd=1,data.panel = 1,avoid.overlapping = F)
kpPlotRegions(kp, data=Hmreg2, r0=-0, r1=0.5, col = "#4575b4",  lwd=1,data.panel = 2,avoid.overlapping = F)


#########################
An <- toGRanges("Analysis/seqdepth/An.chr.bed")
kp1 <- plotKaryotype(genome = An,plot.type=2,main = "Aristichthys nobilis")
Anreg1 <- toGRanges("Analysis/seqdepth/An.hap1.delta.filter.coords.txt.bed")
Anreg2 <- toGRanges("Analysis/seqdepth/An.hap2.delta.filter.coords.txt.bed")

kpPlotRegions(kp1, data=Anreg1, r0=0, r1=0.5, col = "#d73027",  lwd=1,data.panel = 1,avoid.overlapping = F)
kpPlotRegions(kp1, data=Anreg2, r0=-0, r1=0.5, col = "#4575b4",  lwd=1,data.panel = 2,avoid.overlapping = F)
legend("bottomright",legend = c("haplotype1","haplotype2"),fill = c( "#d73027","#4575b4"),bty = "n",col =c( "#d73027","#4575b4") )

#######################
Ci <- toGRanges("Analysis/seqdepth/Ci.chr.bed")
kp2 <- plotKaryotype(genome = Ci,plot.type=2,main = "Ctenopharyngodon idella")
Cireg1 <- toGRanges("Analysis/seqdepth/Ci.hap1.delta.filter.coords.txt.bed")
Cireg2 <- toGRanges("Analysis/seqdepth/Ci.hap2.delta.filter.coords.txt.bed")

kpPlotRegions(kp2, data=Cireg1, r0=0, r1=0.5, col = "#d73027",  lwd=1,data.panel = 1,avoid.overlapping = F)
kpPlotRegions(kp2, data=Cireg2, r0=-0, r1=0.5, col = "#4575b4",  lwd=1,data.panel = 2,avoid.overlapping = F)
############################

Mp <- toGRanges("Analysis/seqdepth/Mp.chr.bed")
kp3 <- plotKaryotype(genome = Mp,plot.type=2,main = "Mylopharyngodon piceus")
Mpreg1 <- toGRanges("Analysis/seqdepth/Mp.hap1.delta.filter.coords.txt.bed")
Mpreg2 <- toGRanges("Analysis/seqdepth/Mp.hap2.delta.filter.coords.txt.bed")

kpPlotRegions(kp3, data=Mpreg1, r0=0, r1=0.5, col = "#d73027",  lwd=1,data.panel = 1,avoid.overlapping = F)
kpPlotRegions(kp3, data=Mpreg2, r0=-0, r1=0.5, col = "#4575b4",  lwd=1,data.panel = 2,avoid.overlapping = F)

## PSMC - parse data
library(tidyverse)
library(magrittr)
source('/Project_analysis/4carps_data analysis/demographic_history.R')

## Parameters
c_lvls <- factor(c("4+25*2+4+6", "4+30*2+4+6+10"))
mu <- c(4.6966e-09,5.4693e-09,4.9627e-09,3.8766e-09)  ## Mutation 1.25e-8 7.2e-09
g <- c(5, 3)        ## Generation 10 3
s <- 100       ## Window size

## All combinations
params <- list(
  mutation = mu,
  generation = g,
  windowSize = s
) %>%
  cross_df() %>%
  slice(c(1,4))
##
## Input data - main + bootstrap combined files
files_psmcCombined <- list.files(path = 'Analysis/psmc/psmc/', 
                                 pattern = '-combined.psmc', 
                                 full.names = TRUE, 
                                 recursive = TRUE) %>%
  set_names(sub('.+/(.*)/(.*)-combined.psmc', '\\1::\\2', .))
###
## Data frame of PSMC results for plotting
tibble_psmc <- pmap(params, function(mutation, generation, windowSize){
  
  map(files_psmcCombined, psmc.result, mu = mutation, s = windowSize, g = generation) %>%
    bind_rows(.id = 'temp') %>%
    separate(col = temp, into = c('reference', 'sample'), sep = '::') %>%
    separate(col = sample, into = c('sample', 'clock'), sep = '-') %>%
    mutate(clock = gsub('_', '+', clock),
           clock = gsub('x', '*', clock),
           mu = mutation,
           gen = generation) %>%
    select(mu, gen, reference, sample, clock, bootstrap, YearsAgo, Ne)
  
}) %>%
  bind_rows() %>%
  mutate(clock = factor(x = clock, levels = c_lvls),
         bootstrap = as.numeric(bootstrap),
         lt = ifelse(bootstrap == 0, 'Standard', 'Bootstrapped'),
         reference = case_when(
           reference == 'Arinob' ~ 'Aristichthys nobilis',
           reference == 'Hypmol' ~ 'Hypophthalmichthys molitrix',
           reference == 'Cteide' ~ 'Ctenopharyngodon idella',
           reference == 'Mylpic' ~ 'Mylopharyngodon piceus',
          
         ),
         sample = case_when(
           sample == 'Arinob2illumina' ~ 'Aristichthys nobilis',
           sample == 'Hypmol2illumina' ~ 'Hypophthalmichthys molitrix',
           sample == 'Cteide2illumina' ~ 'Ctenopharyngodon idella',
           sample == 'Mylpic2illumina' ~ 'Mylopharyngodon piceus',
          
         )) %>%
  group_by(reference, gen, mu) %>%
  nest()

## Save object to prevent re-running
write_rds(x = tibble_psmc, 
          file = 'Analysis/psmc/psmc_z-clean.Rds', 
          compress = 'gz')
################################
dir <- 'Analysis/psmc/clean_PSMC'
dir.create(dir)

## Colour palettes
cp <- c(#RColorBrewer::brewer.pal(n = 11, 'RdYlBu')[c(9,10,11)],
        RColorBrewer::brewer.pal(n = 9, 'YlGnBu')[c(4)],
        RColorBrewer::brewer.pal(n = 9, 'YlOrRd')[5],
        RColorBrewer::brewer.pal(n = 9, 'YlOrRd')[3],
        RColorBrewer::brewer.pal(n = 9, 'YlOrRd')[8])

names(cp) <- c('Aristichthys nobilis', 
               'Hypophthalmichthys molitrix',
               'Ctenopharyngodon idella',
               'Mylopharyngodon piceus')

pc <- c('#000000', '#FF0000')
##

## Data preparation

## Original
df <- pmap(tibble_psmc, function(gen, mu, reference, data){
  
  filter(data, sample == reference) %>%
    mutate(gen = gen,
           mu = mu,
           reference = reference) %>%
    select(reference, sample, gen, mu, clock, bootstrap, everything())
  
}) %>%
  bind_rows()

###
## Plotting

## Single plot - samples to own references - single clock
psmc_singlePlot <- plotPSMC(tbl = df, 
                            g = 5, 
                            c = '4+30*2+4+6+10', 
                            colour_palette = cp)

## Effect of mutation rate/generation time on curve position
psmc_scalingEffect <- plotPSMC_scalingEffect(tbl = df, 
                       c = '4+30*2+4+6+10', 
                       colour_palette = pc)
psmc_scalingEffect <- shift_legend(p = psmc_scalingEffect)

## Effect of reference selection on PSMC curves
plot_refOnNe <- plotXSMC_refEffect(tbl = tibble_psmc,
                                   colour_palette = cp,
                                   filterSample = 'Hydrophis curtus', 
                                   filterRef = 'Hydrophis curtus')
######################
 tbl <- df %>%
    filter(gen == g) %>%
    filter(clock == '4+30*2+4+6+10')
  
  if(!is.null(maxNe)){
    tbl <- filter(tbl, Ne <= maxNe)
  }
  
  if(!is.null(filterSample)){
    tbl <- filter(tbl, ! sample %in% filterSample)
  }

###############################
c <- c("#2166ac","#b2182b","#1b7837","#762a83")
names(c) <- c('Aristichthys nobilis', 
               'Hypophthalmichthys molitrix',
               'Ctenopharyngodon idella',
               'Mylopharyngodon piceus')
####

library(ggplot2)
p <- ggplot(data = df,
              aes(x = YearsAgo, y = Ne,
                  colour = sample,
                  alpha = lt == 'Standard',
                  group = interaction(sample, bootstrap))) +
    geom_step() +
  scale_x_log10(
      breaks = scales::trans_breaks("log10", function(x) 10^x),
      labels = scales::trans_format("log10", scales::math_format(10^.x))
    ) +
    scale_y_log10(
      breaks = scales::trans_breaks("log10", function(x) 10^x),
      labels = scales::trans_format("log10", scales::math_format(10^.x))
    )
  
  if(g == 5){
    p <- p + labs(x = expression(paste("Years before present (g = 5, mu = ",5, 'x', 10^-9, ")")),
                  y = expression(paste('Effective population size (N'[e], ')')))
  } else {
    p <- p + labs(x = expression(paste("Years before present (g = 3, mu = ",5, 'x', 10^-9, ")")),
                  y = expression(paste('Effective population size (N'[e], ')')))
  }
  
  p +
    scale_colour_manual(name = sample, values = c) +
    scale_alpha_manual(values = c(0.1, 1), guide = FALSE) +
    scale_size_manual(values = c(0.4, 1)) +
    theme_classic() +
    theme(legend.justification = c(1, 0), 
          legend.position = c(1, 0),
          legend.box.margin = margin(c(25,25,25,25)),
          legend.title = element_blank(),
          legend.text = element_text(face = 'italic',
                                     size = 16),
          axis.text = element_text(size = 16),
          axis.title = element_text(size = 16)) +
    guides(colour = guide_legend(override.aes = list(size = 5))) +
    annotation_logticks()
####################################
  


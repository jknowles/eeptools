theme_dpi_map2<-function (base_size = 14, base_family = "") {
  require(grid)
  theme_grey(base_size = base_size, base_family = base_family) %+replace% 
    theme(axis.title=element_blank(),
          axis.text = element_blank(),
          axis.ticks = element_blank(), 
          legend.background = element_rect(colour="black"),
          legend.key = element_rect(colour = "grey80"), 
          legend.key.size = unit(.7, "lines"),
          legend.title = element_text(size=base_size*0.7,face="bold"),
          legend.text = element_text(size = base_size * 0.5),
          legend.position = c(.13,.15), 
          legend.direction = 'vertical', 
          legend.justification = "center", 
          panel.background = element_rect(fill = "white",colour = NA), 
          panel.border = element_rect(fill = NA, colour = "grey50"), 
          panel.grid.major = element_blank(), 
          panel.grid.minor = element_blank(), 
          strip.background = element_rect(fill = "grey90",colour = "grey50"), 
          strip.background = element_rect(fill = "grey90",colour = "grey50"),
          strip.text = element_text(size = rel(0.9),face="bold"),
          strip.text.x = element_text(size = rel(0.8),face="bold"),
          strip.text.y = element_text(size = rel(0.8),face="bold"),
          legend.text = element_text(size=base_size*0.65),
          panel.margin=unit(0.48,"cm"),
          plot.margin = unit(c(1, 1, 0.5, 0.5), "lines"),
          plot.title=element_text(size=base_size*1.3)
    )
}

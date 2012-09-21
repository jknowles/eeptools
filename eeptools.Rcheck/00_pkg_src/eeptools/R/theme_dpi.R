theme_dpi<-function (base_size = 16, base_family = "") {
  require(grid)
  theme_grey(base_size = base_size, base_family = base_family) %+replace% 
    theme(axis.title=element_text(size=rel(0.8),face="bold"),
          axis.title.y=element_text(vjust=0.35,angle=90),
          axis.text = element_text(size = rel(0.8)),
          axis.ticks = element_line(colour = "black",size=rel(1.5)), 
          legend.key = element_rect(colour = "grey80"), 
          legend.title = element_text(),
          legend.text = element_text(),
          panel.background = element_rect(fill = "white",colour = NA), 
          panel.border = element_rect(fill = NA, colour = "grey50"), 
          panel.grid.major = element_line(colour = "grey90",size = 0.2), 
          panel.grid.minor = element_line(colour = "grey96", size = 0.5), 
          strip.background = element_rect(fill = "grey90",colour = "grey50"), 
          strip.background = element_rect(fill = "grey90",colour = "grey50"),
          strip.text = element_text(size = rel(0.9),face="bold"),
          strip.text.x = element_text(size = rel(0.9),face="bold"),
          strip.text.y = element_text(size = rel(0.9),face="bold"),
          legend.text = element_text(),
          legend.title = element_text(),
          panel.margin=unit(0.48,"cm")
          )
  }

#qplot(wt,mpg*100,data=mtcars,color=hp,shape=as.factor(carb),size=I(2.5))+theme_dpi()+facet_wrap(~gear)+
#  labs(x="My Var",y="Something way too long as usual",title="TEST")


#qplot(wt,mpg*100,data=mtcars,color=hp,shape=as.factor(carb))+theme_dpi()+facet_grid(am~gear)+
#  labs(x="My Var",y="Something way too long as usual",title="TEST")+coord_flip()

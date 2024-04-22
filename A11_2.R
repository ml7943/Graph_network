# install.packages(c("glasso", "ggplot2", "igraph"))
# install.packages("/Users/limu/Desktop/course/ML/A11_MuLi/space_0.1-1.1.tar.gz", repos = NULL, type = "source")
library(glasso)
library(ggplot2)
library(igraph)
library(space)

##################### Method 1: Glasso ##############################
rm(list = ls())

load("/Users/limu/Desktop/course/ML/A11_MuLi/data_retro.RData")
data<- t(data)
p<- dim(data)[2] # no. of nodes
n=nrow(data)
s<- var(data)
a<-glasso(s, rho=0.05)
a$w[1:10,1:10]
a$wi[1:10,1:10]

## No. of detected edges
fit.gl=abs(a$wi)>1e-6
sum(fit.gl==1)/2

## degree
glasso.degree=apply(fit.gl, 2, sum)

tab<- cbind.data.frame("Nodes"=colnames(data), "degree"=glasso.degree)
ss<- sort(tab$degree, ind=T, decreasing = T)
tab.sort<- tab[ss$ix,]
tab.sort$Nodes<- factor(tab.sort$Nodes, levels=unique(tab.sort$Nodes))
dat<- tab.sort[1:30,]

ggplot(dat, aes(y=degree, x=Nodes)) +geom_bar(position="stack", stat="identity") + theme_bw() + theme(axis.text.x = element_text(colour="black",size=15,angle=45,hjust=1,vjust=1,face="plain"),axis.title.x = element_text(colour="black",size=25,angle=0,hjust=.5,vjust=.5,face="plain"), axis.text.y = element_text(colour="black",size=15,angle=0,hjust=1,vjust=0,face="plain"),  axis.title.y = element_text(colour="black",size=25,angle=90,hjust=.5,vjust=.5,face="plain"),legend.title = element_text(colour="black",size=15), legend.text=element_text(colour="black",size=15), legend.direction = "horizontal", legend.position = "top") + theme(plot.margin = unit(c(1,1,1,1), "cm"))

ggsave("/Users/limu/Desktop/course/ML/A11_MuLi/degree_distribution_glasso.png", plot = last_plot(), width = 10, height = 6, dpi = 300)

##################### Method 2: Space.joint ##############################
rm(list = ls())

load("/Users/limu/Desktop/course/ML/A11_MuLi/data_retro.RData")  
data<- t(data)
p<- dim(data)[2] # no. of nodes
n=nrow(data)

alpha=1
l1=1/sqrt(n)*qnorm(1-alpha/(2*p^2))
iter=10

result2=space.joint(data, lam1=6, lam2=0, iter=iter)
result2$ParCor[1:10,1:10]

## No. of detected edges
fit.space.jt=abs(result2$ParCor)>1e-6
sum(fit.space.jt==1)/2

## degree
spacejt.degree=apply(fit.space.jt, 2, sum)

tab<- cbind.data.frame("Nodes"=colnames(data), "degree"=spacejt.degree)
ss<- sort(tab$degree, ind=T, decreasing = T)
tab.sort<- tab[ss$ix,]
tab.sort$Nodes<- factor(tab.sort$Nodes, levels=unique(tab.sort$Nodes))
dat<- tab.sort[1:30,]

ggplot(dat, aes(y=degree, x=Nodes)) +geom_bar(position="stack", stat="identity") + theme_bw() + theme(axis.text.x = element_text(colour="black",size=15,angle=45,hjust=1,vjust=1,face="plain"),axis.title.x = element_text(colour="black",size=25,angle=0,hjust=.5,vjust=.5,face="plain"), axis.text.y = element_text(colour="black",size=15,angle=0,hjust=1,vjust=0,face="plain"),  axis.title.y = element_text(colour="black",size=25,angle=90,hjust=.5,vjust=.5,face="plain"),legend.title = element_text(colour="black",size=15), legend.text=element_text(colour="black",size=15), legend.direction = "horizontal", legend.position = "top") + theme(plot.margin = unit(c(1,1,1,1), "cm"))
ggsave("/Users/limu/Desktop/course/ML/A11_MuLi/degree_distribution_spacejoint.png", plot = last_plot(), width = 10, height = 6, dpi = 300)

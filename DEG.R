
#######  Select DEGs from RNA seq Data
setwd("F:/�������յ��ֻ���ѧ���ݷ���/Data")  
Gene_RPKM=read.csv("F:/�������յ��ֻ���ѧ���ݷ���/Data/GBM_gene_RPKM.csv")
Gene_RPKM=na.omit(Gene_RPKM)
Gene_S=Gene_RPKM[,2:6]  ## Sensitive cell line
Gene_R=Gene_RPKM[,7:11] ## Resistant cell line
Gene_S=matrix(as.numeric(as.matrix(Gene_S)),dim(Gene_S)[1],dim(Gene_S)[2])
Gene_R=matrix(as.numeric(as.matrix(Gene_R)),dim(Gene_R)[1],dim(Gene_R)[2])
rownames(Gene_S)=Gene_RPKM[,1]
rownames(Gene_R)=Gene_RPKM[,1]

###### DEG compared with 0 hour
DEG_S0=matrix(0,1,4)
for (i in 1:dim(Gene_S)[1]) 
{ for (j in 2:5)
{if ((max(Gene_S[i,])>=10) & (Gene_S[i,1]>0) & (Gene_S[i,j]>0) & (Gene_S[i,j]/Gene_S[i,1]>2 || Gene_S[i,j]/Gene_S[i,1]<0.5))
  {
  DEG_S0[,j-1]=DEG_S0[,j-1]+1
  }
}
}
DEG_S0=unique(DEG_S0)

DEG_R0=matrix(0,1,4)
for (i in 1:dim(Gene_R)[1]) 
{ for (j in 2:5)
{if ((max(Gene_R[i,])>=10) & (Gene_R[i,1]>0) & (Gene_R[i,j]>0) & (Gene_R[i,j]/Gene_R[i,1]>2 || Gene_R[i,j]/Gene_R[i,1]<0.5))
  {
  DEG_R0[,j-1]=DEG_R0[,j-1]+1
  }
}
}

DEG_R0=unique(DEG_R0)

DEG_S0
DEG_R0
###############

###### DEG compared with 0 hour
DEG_S1=matrix(0,1,4)
for (i in 1:dim(Gene_S)[1]) 
{ for (j in 2:5)
{if ((max(Gene_S[i,])>=10) & (Gene_S[i,1]>0) & (Gene_S[i,j]>0) & (Gene_S[i,j]/Gene_S[i,j-1]>2 || Gene_S[i,j]/Gene_S[i,j-1]<0.5))
{
  DEG_S1[,j-1]=DEG_S1[,j-1]+1
}
}
}
DEG_S1=unique(DEG_S1)

DEG_R1=matrix(0,1,4)
for (i in 1:dim(Gene_R)[1]) 
{ for (j in 2:5)
{if ((max(Gene_R[i,])>=10) & (Gene_R[i,1]>0) & (Gene_R[i,j]>0) & (Gene_R[i,j]/Gene_R[i,j-1]>2 || Gene_R[i,j]/Gene_R[i,j-1]<0.5))
{
  DEG_R1[,j-1]=DEG_R1[,j-1]+1
}
}
}

DEG_R1=unique(DEG_R1)

DEG_S1
DEG_R1

####  ��˫������
install.packages('plotrix')
library(plotrix)
xpos <- 1:4
xlabel = c('6h/0h', '12h/0h','24h/0h', '48h/0h')
twoord.plot(xpos,DEG_S0,xpos,DEG_R0,xlim=c(0.5,4.5),lylim=c(0,max(DEG_S0)+200),rylim=c(0,max(DEG_R0)+200), lpch=21,rpch=22,bg='green',lcol=4,rcol=2,ylab="Number of sensitive DEGs",rylab="Number of resistant DEGs",type=c("b","b"),xticklab=xlabel,halfwidth=0.2,cex.axis=1.5,cex.label=3)
legend("top",legend=c("Sensitive cells","Resistant cells"),pch=c(21,22),col=c(4,2))
legend('boxoff')

dev.off()

###### TCG of sensitive cells
timestart<-Sys.time()
DEG_S=c()
RNames_DEG_S=c()
for (i in 1:dim(Gene_S)[1]) 
{ for (j in 1:5)
  { for (k in 1:max(j-1,1))
    {if ((max(Gene_S[i,])>=10) & (Gene_S[i,k]>0) & (Gene_S[i,j]>0) & (Gene_S[i,j]/Gene_S[i,k]>5 || Gene_S[i,j]/Gene_S[i,k]<0.2)){
      DEG_S=rbind(DEG_S,Gene_S[i,])
      RNames_DEG_S=rbind(RNames_DEG_S,rownames(Gene_S)[i])
    }
    }
  }
}
rownames(DEG_S)=RNames_DEG_S
DEG_S=unique(DEG_S)
# DEG_S=DEG_S[-1,]
timeend<-Sys.time()
runningtime<-timeend-timestart
print(runningtime)


summary(DEG_S)
dim(DEG_S)  #163,5

plot(c(0,6,12,24,48),DEG_S["STC1",],type="b",main="DEG_S",sub='',xlim=c(0,50), ylim=c(min(DEG_S["STC1",]), max(DEG_S["STC1",])),xlab="Time (Hours)",ylab='Gene Expression')



####  TCG of resistance 

timestart<-Sys.time()
DEG_R=c()
RNames_DEG_R=c()
for (i in 1:dim(Gene_R)[1]) 
{ for (j in 1:5)
{ for (k in 1:max(j-1,1))
{if ((max(Gene_R[i,])>=10) & (Gene_R[i,k]>0) & (Gene_R[i,j]>0) & (Gene_R[i,j]/Gene_R[i,k]>5 || Gene_R[i,j]/Gene_R[i,k]<0.2)){
  DEG_R=rbind(DEG_R,Gene_R[i,])
  RNames_DEG_R=rbind(RNames_DEG_R,rownames(Gene_R)[i])
}
}
}
}
rownames(DEG_R)=RNames_DEG_R
DEG_R=unique(DEG_R)
# DEG_S=DEG_S[-1,]
timeend<-Sys.time()
runningtime<-timeend-timestart
print(runningtime)


summary(DEG_R)
dim(DEG_R)  #101,5

# plot(c(0,6,12,24,48),DEG_R["STC1",],type="b",main="DEG_R",sub='',xlim=c(0,50), ylim=c(min(DEG_R["STC1",]), max(DEG_R["STC1",])),xlab="Time (Hours)",ylab='Gene Expression')


########## 

intersect(rownames(DEG_S),rownames(DEG_R))


#####  Save TCGs 
setwd("F:/�������յ��ֻ���ѧ���ݷ���/Code-cluster_based/Results")
write.table(DEG_S, file="Drug Sensitive Genes.txt")
write.table(DEG_R, file="Drug Resistant Genes.txt")
# 
# 
# DEG_S=read.table("F:/�������յ��ֻ���ѧ���ݷ���/Code-cluster_based/Results/Drug Sensitive Genes.txt")
# DEG_R=read.table("F:/�������յ��ֻ���ѧ���ݷ���/Code-cluster_based/Results/Drug Resistant Genes.txt")



names_SR=union(rownames(DEG_S),rownames(DEG_R))

TC_gene_1=Gene_S[names_SR,]  # Temporally changing genes of sensitivity
TC_gene_2=Gene_R[names_SR,]  # Temporally changing genes of resistance

dim(TC_gene_2)  # 251,5

###### Normalization
TC_gene_1_Normalized=TC_gene_1
TC_gene_2_Normalized=TC_gene_2

for (i in 1:dim(TC_gene_1)[1])
{
  if (max(TC_gene_1[i,]!=0))
  {
    TC_gene_1_Normalized[i,]=TC_gene_1[i,]/max(TC_gene_1[i,])
  }
  
  if (max(TC_gene_2[i,]!=0))
  {
    TC_gene_2_Normalized[i,]=TC_gene_2[i,]/max(TC_gene_2[i,])
  }
  
  
}

colnames(TC_gene_1_Normalized)=c("S_D1","S_D2","S_D3","S_D4","S_D5")
colnames(TC_gene_2_Normalized)=c("R_D1","R_D2","R_D3","R_D4","R_D5")

 setwd("F:/�������յ��ֻ���ѧ���ݷ���/Code-cluster_based/Results")  
 write.table(TC_gene_1_Normalized, file="TC_gene_1_Normalized.txt",col.names = NA,sep = "\t") 
 write.table(TC_gene_2_Normalized, file="TC_gene_2_Normalized.txt",col.names = NA,sep = "\t")

####  Heatmap

install.packages("gplots") #����gplots�����
library(gtools) #����gplots����
library(gplots) #����gplots����

install.packages("caTools") #����gplots�����



x=t(cbind(as.matrix(TC_gene_1_Normalized),as.matrix(TC_gene_2_Normalized)))


heatmap.2(x,col=greenred,distfun = dist,hclustfun = hclust,scale="none", Rowv=NA,Colv=T,dendrogram="col",key=T,keysize=1.5,trace="none",cexCol=0.5,cexRow=1,na.color=par("bg"))

x_S=t(as.matrix(TC_gene_1_Normalized))
x_R=as.matrix(TC_gene_2_Normalized)
hv1=heatmap.2(x_S,col=colorRampPalette(c("navy", "white", "firebrick3"))(50),scale="none",Rowv=NA,Colv=T,dendrogram="col",key=T,keysize=1.5,trace="none",cexCol=0.5,cexRow=1)
hv2=heatmap.2(t(x_R),distfun = dist,hclustfun = hclust,scale="none",na.rm=TRUE,col=colorRampPalette(c("navy", "white", "firebrick3")),Rowv=NA,Colv=T,dendrogram="col",key=T,keysize=1.5,trace="none",cexCol=0.5,cexRow=1)

dev.off()

hv1=heatmap.2(x_S,col=redblue(100),scale="none",Rowv=NA,Colv=T,dendrogram="col",key=T,keysize=1.5,trace="none",cexCol=0.5,cexRow=1)
hv2=heatmap.2(t(x_R),distfun = dist,hclustfun = hclust,scale="none",na.rm=TRUE,col=redblue(100),Rowv=NA,Colv=T,dendrogram="col",key=T,keysize=1.5,trace="none",cexCol=0.5,cexRow=1)


library(pheatmap)
pheatmap(x_S,cluster_row=FALSE, cellwidth = 2, cellheight = 20,color = colorRampPalette(c("navy", "white", "firebrick3"))(50), fontsize=9, fontsize_row=6,labRow=NA) #�Զ�����ɫ
pheatmap(t(x_R),cluster_row=FALSE, cellwidth = 5, cellheight = 20,color = colorRampPalette(c("navy", "white", "firebrick3"))(50), fontsize=9, fontsize_row=6) #�Զ�����ɫ





 
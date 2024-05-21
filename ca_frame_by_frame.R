library(bio3d)
library(reshape)
#########################Loading pdb##########################
pdbiti= read.pdb("1j0t_ca.pdb", multi = T)
pdbiti
#################################creating the distance matrix#############################
dm1= dm(pdbiti$xyz,method = "euclidean"  )
################converting all NA values to zero#############################
dm1[is.na(dm1)]<-0
dm1
#######################transposing all the frames in our trajectory######################
for(fr in 30000 ){
  dm1[[fr]][lower.tri(dm1[[fr]])] <- 
    t(dm1[[fr]])[lower.tri(dm1[[fr]])]
  
}
class(dm1)
#################melting all the frames into 4 columns################
melted_data_frames= melt.array(dm1)
class(melted_data_frames)
nrow(melted_data_frames)
mdf <- melted_data_frames %>% filter(value != 0.000000)
head(mdf)
####################removing the 3rd column as it is of no use###########################
mdf <- mdf[, !(names(mdf) %in% c("X3"))]
head(mdf)
###################saving it for further analysis################################

help("melt")
write.csv(melted_data_frames , "three_calpha_loop.csv", row.names = F)
write.csv(mdf , "1j0t_allatom_fbf.csv", row.names = F)


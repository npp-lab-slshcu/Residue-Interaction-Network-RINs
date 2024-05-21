#RESIDUE INTERACTION NETWORK#############
##BY AVERAGING THE FRAMES######################
#trying for AVERAGE frames:-(SUCCESSFUL)
library(bio3d)
library(reshape)
library(dplyr)
library(igraph)
options(max.print = 1000000)
##loading the pdb#############
pdb_con <- read.pdb("trajectry.pdb", maxlines = -1, multi = T)
pdb_con
####creating the euclidean distance#######################
dist_mat= dm(pdb_con$xyz, method = "euclidean" )
dim(dist_mat)
######################TAKING THE AVERAGE OF ALL THE FRMES###################
average_dist_matrix <- apply(dist_mat , MARGIN = c(1, 2), FUN = mean)
average_dist_matrix
########checking the class of the newly formed matrix###########################
class(average_dist_matrix)
average_dist_matrix[is.na(average_dist_matrix)]<-0
average_dist_matrix
nrow(average_dist_matrix)
ncol(average_dist_matrix)
########################taking the transpose of the matrix#############################
average_dist_matrix[lower.tri(average_dist_matrix)] <- t(average_dist_matrix)[lower.tri(average_dist_matrix)]
my_cor_df1 <- melt(average_dist_matrix)
my_cor_df1
########################removing the rows with similar nodes###############
my_cor_df2 <- my_cor_df1 %>% filter(value != 0.000000)
my_cor_df3 = my_cor_df2 %>% filter(value  <= 8.000000  )
my_cor_df3
#################creating the nodelist based on distance cut-off###############################

result <- my_cor_df3$X2 - my_cor_df3$X1

# Create a dataframe from the result
result_df <- data.frame(Result = result)
View(result_df)
result_df
final_dataset <- cbind(my_cor_df3, Result = result_df)
final_dataset
filtered_result_df <- final_dataset %>%filter(Result > 0)
filtered_result_df
View(my_cor_df3)
View(filtered_result_df)

selected_df8 <- select(filtered_result_df, X1, X2)
View(selected_df8)
write.csv(selected_df8,"pdb_nodelist.csv", row.names = F)
###########################creating the graph####################

graphpdb = graph_from_data_frame(selected_df8, directed = FALSE )
edge_density(graphpdb)
graphpdb
plot(graphpdb)

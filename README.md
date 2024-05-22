There are in total three files here out of which two are in R and one in python.  These codes can be used to build a RIN with any type of trajectory data, be it all-atom, coarse grained models, ENMs etc. The file "graph_average_of_frames.R" 
has the complete step-by-step code for building a RIN by taking and average of all the frames that you have fed to the code and getting one node list in the end and analysis can be done of all the network properties for that one graph.
The other two codes is a little more complicated as using those you can create a network for each and every frame of your trajectory file and then take the average of those network properties. 
The code starts in "ca_frame_by_frame.R" where by the end you create a data frame which will consist the edge list for all the frames. We will then load it in python.
The logic for using python is that if you are working with a large number of frames, which in my case was 30000, python will be better at handling such a big data load .
Then the first code in python is for splitting the data frame into smaller individual frames. This makes use of the row number at which the last line of the first frame is ending and has to be checked manually( unfortunately).
You can use LibreOffice Calc for opening those if you are using a linux system. After splitting you can making a network for each split data frame.

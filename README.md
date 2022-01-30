# MASTER's THESIS: Recognition of Music Cover Versions using Music Information Retrieval Techniques

Using artificial neural networks (convolution and fully conected) for music cover recognotion. This whole work is written in MATLAB (MIRtoolbox) and Python (Keras, TensorFlow). There is 1 datasets used as a source for neural networks. This work contains two methods fo cover song recognition. The first one is written in MATLAB, the second one use MATLAB for preproces data and for special evaluation method. In this method is Python used for implementation Convolutional network, traning, testing etc.Whole thesis is written in czech language. So excause the czech names of function's, czech coments etc. 

## CZECH NOTE: Podrobný popis, myšlenkový postup a vysvětlení je v pdf diplomové práce 

- University: Brno University of Technology, Czech Republic
- Faculty: Faculty of Electrical Engineering and Communication, Department of Telecomunications
- Field of Study: Audio Engineering
- Supervisor: Ing. Tomáš Kiska
- Author: Bc. Václav Martinek

## METHOD DESCRIPTION

# 1st Method
This method counts all parametres that MIRtoolbox offer from all songs from the dataset. These parameters are represented by vectors, matrices and scalars. For classification we need only scalars. For this reason we this method used statistic functions (mean, median, var, percentil etc.) for computing scalars from vectors and matrices. On statistisc parameters is used mRMR method for selecting the best parameters. After selecting best_ n _parameters is used neural network (BPNN.m) for clasification.

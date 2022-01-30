# MASTER's THESIS: Recognition of Music Cover Versions using Music Information Retrieval Techniques

Using artificial neural networks (convolution and fully conected) for music cover recognotion. This whole work is written in MATLAB (MIRtoolbox) and Python (Keras, TensorFlow). There is 1 datasets used as a source for neural networks. This work contains two methods for cover song recognition. The first one is written in MATLAB, the second one use MATLAB for preproces data and for special evaluation method. In this method is Python used for implementation Convolutional neural network, traning, testing etc. Whole thesis is written in czech language. So excause the czech names of function's, czech coments etc. 

## CZECH NOTE: Podrobný popis, myšlenkový postup a vysvětlení je v pdf diplomové práce 
odkaz na diplomovou práci: https://dspace.vutbr.cz/handle/11012/197118

- University: Brno University of Technology, Czech Republic
- Faculty: Faculty of Electrical Engineering and Communication, Department of Telecomunications
- Field of Study: Audio Engineering
- Supervisor: Ing. Tomáš Kiska
- Author: Bc. Václav Martinek

## METHOD DESCRIPTION

# 1st Method
This method counts all parametres that MIRtoolbox offer from all songs from the dataset. These parameters are represented by vectors, matrices and scalars. For classification we need only scalars. For this reason we this method used statistic functions (mean, median, var, percentil etc.) for computing scalars from vectors and matrices. On statistisc parameters is used mRMR method for selecting the best parameters. After selecting best _n_ parameters is used neural network (BPNN.m) for clasification. There is also method called PCA (pca folder) for visualization selected parameters.

# 2nd Method
This method use only chromagram parametr. Chromagram is matrix that show us tonal content in time. We used only the first 180 _second_ from each song to compute chromagram. we used 1 _second_ no overlap window, so chromagrams had size (12,180). On chormagrams pairs we applied OTI method (Optimal Transpose Index) for unification of key. From these pairs we compute CSM (Cross Similiarity Matrix). CSM is matrix (180,180) that show us similiarity between two Chromagrams / songs. If we plot the CSM which is made from two cover versions we can observe diagonal stripes. CSM from two Non-Covers ussually shows horizontal or vertical stripes. We have two possibility how to create CSM from our dataset (MIRtoolbox, Chroma toolbox) in MATLAB. These medthods are contains in MATLAB folder. For classification CSM was used CNN in Python. Classification is binary, so after predicting we used special ranking system which is written in MATLAB. This system used evaluating metrics like MAP, MR1, MNIT5 (like MIREX). 

This method is inspired by Korean authors. You can read their work here:

https://www.music-ir.org/mirex/abstracts/2018/LCLL1.pdf
https://ieeexplore.ieee.org/document/8461395
https://www.researchgate.net/publication/337005573_Learning_a_Representation_for_Cover_Song_Identification_Using_Convolutional_Neural_Network

## MATLAB and Python requirements

This work was build with MATLAB 2016a and Python 3.6.

### Matlab
 - MIRtoolbox 1.7
 - Chroma Toolbox
 - mRMR function (you must compile this toolbox for your system .mex files)
 - cell2csv
 - pca

### Python
 - NumPy
 - TenosFlow 2.6
 - scipi
 - h5py
 
 ## Dataset
 
The dataset is downloaded from Youtube. I used Youtube-DL console app (https://youtube-dl.org/). This app can download top _n_ songs that youtube found for your query.

I divided the dataset into 10 folders. Each folder is for one music genre. So this dataset contains 10 music genres like:

- Pop
- Rock
- Disco
- Blues
- Folk & Country
- Hip Hop & Rap
- Jazz
- Metal
- Classic music
- Reggae

Each music genre contains 20 original songs. For each original song was 5 cover verions.

## How to get the DATASET

The dataset is too big for uploading on the github or on the interner. Here is link for google disk where is files that contains names of the songs in the dataset: https://docs.google.com/spreadsheets/d/1DySmCE8FBA_urazBxR_ycJTGkRkg5442hzWAmqtspWQ/edit?usp=sharing

Every method should have _Link.txt_ file where is written link where you can download parameters which was computated from the dataset. If you want to download the dataset (mp3 files) send me a message.

## How to run each methods

Each methods should have in MATLAB _demo.m_ script. 2nd method used CNN in Python for training and predicting. You can training with _main.py_ For predicting you must run _Testovani.py_. For evaluating 2nd method in MATLAB you must run _Testovani.m_ in Testing folder. 

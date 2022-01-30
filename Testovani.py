from tensorflow import keras
from Zmeannorm import normalizace
import h5py
from scipy import io
from prevod import format_H5PY
import numpy as np

#nacteni modelu
model_end = keras.models.load_model('CNN_END_Blues.h5')
model_min = keras.models.load_model('trained_models/CNN_Blues.h5')

#nacteni 1. casti dat testovani
Test_1 = h5py.File('Test_Data_Part_1.mat', 'r') #nacteni verze '7.3' .mat souboru
Testovaci_Data_1 = format_H5PY(Test_1, 'Test_Data_Part_1')#formatovani na array pro testovani
Test_Label_1 = io.loadmat('Test_Label_vec_Part_1.mat')
Test_Label_1 = Test_Label_1['Test_Label_vec_Part_1']

del Test_1 #odstraneni zbytecne promene

Testovaci_Data_1 = np.float32(Testovaci_Data_1) #float 32
Testovaci_Data_1 = normalizace(Testovaci_Data_1) #normalizace
Test_Label_1 = np.float32(Test_Label_1)

result_1_end = model_end.predict(x=Testovaci_Data_1) #testovani
result_1_min = model_min.predict(x=Testovaci_Data_1) #testovani

Evaluace_1_end = model_end.evaluate(x=Testovaci_Data_1, y=Test_Label_1)
Evaluace_1_min = model_min.evaluate(x=Testovaci_Data_1, y=Test_Label_1)

del Testovaci_Data_1 #odstraneni testovacich dat
del Test_Label_1
io.savemat('Test_Pred_1_end.mat', {"foo":result_1_end}) #ulozeni vysledku {}
io.savemat('Test_Pred_1_min.mat', {"foo":result_1_min}) #ulozeni vysledku {}
io.savemat('Evaluace_1_end.mat', {"foo":Evaluace_1_end})
io.savemat('Evaluace_1_min.mat', {"foo":Evaluace_1_min})





#nacteni 2. casti dat testovani
Test_2 = h5py.File('Test_Data_Part_2.mat', 'r') #nacteni verze '7.3' .mat souboru
Testovaci_Data_2 = format_H5PY(Test_2, 'Test_Data_Part_2')#formatovani na array pro testovani
Test_Label_2 = io.loadmat('Test_Label_vec_Part_2.mat')
Test_Label_2 = Test_Label_2['Test_Label_vec_Part_2']

del Test_2 #odstraneni zbytecne promene
Testovaci_Data_2 = np.float32(Testovaci_Data_2) #float 32
Testovaci_Data_2 = normalizace(Testovaci_Data_2) #normalizace
Test_Label_2 = np.float32(Test_Label_2)

result_2_end = model_end.predict(x=Testovaci_Data_2) #testovani
result_2_min = model_min.predict(x=Testovaci_Data_2) #testovani

Evaluace_2_end = model_end.evaluate(x=Testovaci_Data_2, y=Test_Label_2)
Evaluace_2_min = model_min.evaluate(x=Testovaci_Data_2, y=Test_Label_2)

del Testovaci_Data_2 #odstraneni testovacich dat
del Test_Label_2
io.savemat('Test_Pred_2_end.mat', {"foo":result_2_end}) #ulozeni vysledku {}
io.savemat('Test_Pred_2_min.mat', {"foo":result_2_min}) #ulozeni vysledku {}
io.savemat('Evaluace_2_end.mat', {"foo":Evaluace_2_end})
io.savemat('Evaluace_2_min.mat', {"foo":Evaluace_2_min})



#nacteni 3. casti dat testovani
Test_3 = h5py.File('Test_Data_Part_3.mat', 'r') #nacteni verze '7.3' .mat souboru
Testovaci_Data_3 = format_H5PY(Test_3, 'Test_Data_Part_3')#formatovani na array pro testovani
Test_Label_3 = io.loadmat('Test_Label_vec_Part_3.mat')
Test_Label_3 = Test_Label_3['Test_Label_vec_Part_3']

del Test_3 #odstraneni zbytecne promene
Testovaci_Data_3 = np.float32(Testovaci_Data_3) #float 32
Testovaci_Data_3 = normalizace(Testovaci_Data_3) #normalizace
Test_Label_3 = np.float32(Test_Label_3)

result_3_end = model_end.predict(x=Testovaci_Data_3) #testovani
result_3_min = model_min.predict(x=Testovaci_Data_3) #testovani

Evaluace_3_end = model_end.evaluate(x=Testovaci_Data_3, y=Test_Label_3)
Evaluace_3_min = model_min.evaluate(x=Testovaci_Data_3, y=Test_Label_3)

del Testovaci_Data_3 #odstraneni testovacich dat
del Test_Label_3
io.savemat('Test_Pred_3_end.mat', {"foo":result_3_end}) #ulozeni vysledku {}
io.savemat('Test_Pred_3_min.mat', {"foo":result_3_min}) #ulozeni vysledku {}
io.savemat('Evaluace_3_end.mat', {"foo":Evaluace_3_end})
io.savemat('Evaluace_3_min.mat', {"foo":Evaluace_3_min})



#nacteni 4. casti dat testovani
Test_4 = h5py.File('Test_Data_Part_4.mat', 'r') #nacteni verze '7.3' .mat souboru
Testovaci_Data_4 = format_H5PY(Test_4, 'Test_Data_Part_4')#formatovani na array pro testovani
Test_Label_4 = io.loadmat('Test_Label_vec_Part_4.mat')
Test_Label_4 = Test_Label_4['Test_Label_vec_Part_4']
del Test_4 #odstraneni zbytecne promene
Testovaci_Data_4 = np.float32(Testovaci_Data_4) #float 32
Testovaci_Data_4 = normalizace(Testovaci_Data_4) #normalizace
Test_Label_4 = np.float32(Test_Label_4)

result_4_end = model_end.predict(x=Testovaci_Data_4) #testovani
result_4_min = model_min.predict(x=Testovaci_Data_4) #testovani

Evaluace_4_end = model_end.evaluate(x=Testovaci_Data_4, y=Test_Label_4)
Evaluace_4_min = model_min.evaluate(x=Testovaci_Data_4, y=Test_Label_4)

del Testovaci_Data_4 #odstraneni testovacich dat
del Test_Label_4
io.savemat('Test_Pred_4_end.mat', {"foo":result_4_end}) #ulozeni vysledku {}
io.savemat('Test_Pred_4_min.mat', {"foo":result_4_min}) #ulozeni vysledku {}
io.savemat('Evaluace_4_end.mat', {"foo":Evaluace_4_end})
io.savemat('Evaluace_4_min.mat', {"foo":Evaluace_4_min})

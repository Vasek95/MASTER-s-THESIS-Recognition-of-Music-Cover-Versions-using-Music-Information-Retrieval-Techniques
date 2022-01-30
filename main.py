from scipy import io
import numpy as np
from prevod import format
from model import CNN
from tensorflow.keras.callbacks import ModelCheckpoint, TensorBoard, ReduceLROnPlateau, CSVLogger
from Zmeannorm import normalizace

#pro malovani matic
import matplotlib.pyplot as plt

#naciteni mat filu
Tren = io.loadmat('Tren_Data.mat') #je to ditcionary
Tren_l = io.loadmat('Tren_Label.mat') #je to ditcionary

Valid = io.loadmat('Valid_Data.mat') #je to ditcionary
Valid_l = io.loadmat('Valid_Label.mat') #je to ditcionary

# prevedeni na numpy array 4200 180 180 - tak aby to vzala CNN
#       - hodnoty a poradi matic v MATLABu a tady po tomto formatovani souhlasi
Trenovaci_Data = format(Tren,'Tren_Data')
Trenovaci_Label = Tren_l['Tren_Label']
del Tren
del Tren_l
Validacni_Data = format(Valid, 'Valid_Data')
Validacni_Label = Valid_l['Valid_Label']
del Valid
del Valid_l

#pretypovani na float 32  - zadne vyrazne zmeny v uceni nevidim
Trenovaci_Data = np.float32(Trenovaci_Data)
Validacni_Data = np.float32(Validacni_Data)

Trenovaci_Label = np.float32(Trenovaci_Label)
Validacni_Label = np.float32(Validacni_Label)

#Z -standardtizace - zadne vyrazne zmeny v uceni nevidim
Trenovaci_Data = normalizace(Trenovaci_Data)
Validacni_Data = normalizace(Validacni_Data)

#rozzsireni dimenze na [180,180,1] - zadne vyrazne zmeny v uceni nevidim
"""Trenovaci_Data = np.expand_dims(Trenovaci_Data, axis=-1)
Validacni_Data = np.expand_dims(Validacni_Data, axis=-1) """

#validacni tuplice - Keras vyzaduje valid data jako tuplici
Validacni_Tuple =(Validacni_Data, Validacni_Label)

#trenovani
model_type = 'CNN'
dataset_name = 'Blues'
csv_path = 'csv_logs/{}_{}'.format(model_type, dataset_name) + '.csv'
cp = ModelCheckpoint('trained_models/{}_{}.h5'.format(model_type, dataset_name), monitor='val_loss',
                         save_best_only=True, save_weights_only=False, mode='auto', save_freq='epoch', verbose=1)
reducelr = ReduceLROnPlateau(monitor='val_loss', min_lr=0.00001, factor=0.5, patience=25,
                                 min_delta=0.01, verbose=1)
tensorboard = TensorBoard(log_dir='tensorboard_logs/{}_{}'.format(model_type, dataset_name), profile_batch=0)
csv_logger = CSVLogger(filename=csv_path)

model = CNN() #to je tam kvuli tomu aby se zkompiloval
model.fit(x=Trenovaci_Data, y=Trenovaci_Label, epochs=50, batch_size=50, shuffle=True,
          callbacks=[cp, tensorboard, reducelr, csv_logger], validation_data=Validacni_Tuple)

#ulozeni modelu
model.save('CNN_END_Blues.h5')

# tensorboard --logdir=C:\Users\teste\PycharmProjects\pythonProject - tohle pisu do prikazoveho radku pro otevreni grafu v prohlizeci """
#timto muzu zobrazit danou matici
#plt.imshow(Validacni_Data[305])
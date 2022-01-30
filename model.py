from tensorflow.keras import layers #importuje keras
from tensorflow.keras import Model #pro kompilovani
from tensorflow.keras import metrics
from tensorflow.keras import optimizers
def CNN(): #vstupni promene do fce v zavorce

    i = layers.Input(shape=(180, 180, 1), name='input') #vstupni vrtsva

    #Block 1
    conv1 = layers.Conv2D(filters=32, kernel_size=(5, 5), activation='relu')(i) #1. conv vrstva, (i) znamena input - functional API
    conv2 = layers.Conv2D(filters=32, kernel_size=(5, 5), activation='relu')(conv1)
    maxpool1 = layers.MaxPool2D(pool_size=(2,2))(conv2)
    BN1 = layers.BatchNormalization()(maxpool1)

    # Block 2
    conv3 = layers.Conv2D(filters=32, kernel_size=(3, 3), activation='relu')(BN1)
    conv4 = layers.Conv2D(filters=16, kernel_size=(3, 3), activation='relu')(conv3)
    maxpool2 = layers.MaxPool2D(pool_size=(2,2))(conv4)
    BN2 = layers.BatchNormalization()(maxpool2)

    # Block 3
    conv5 = layers.Conv2D(filters=32, kernel_size=(3, 3), activation='relu')(BN2)
    conv6 = layers.Conv2D(filters=16, kernel_size=(3, 3), activation='relu')(conv5)
    maxpool3 = layers.MaxPool2D(pool_size=(2,2))(conv6)
    BN3 = layers.BatchNormalization()(maxpool3)

    # Block 4
    conv7 = layers.Conv2D(filters=32, kernel_size=(3, 3), activation='relu')(BN3)
    conv8 = layers.Conv2D(filters=16, kernel_size=(3, 3), activation='relu')(conv7)
    maxpool4 = layers.MaxPool2D(pool_size=(2, 2))(conv8)
    BN4 = layers.BatchNormalization()(maxpool4)

    # Block 5
    conv9 = layers.Conv2D(filters=32, kernel_size=(3, 3), activation='relu')(BN4)
    conv10 = layers.Conv2D(filters=16, kernel_size=(3, 3), activation='relu')(conv9)
    maxpool5 = layers.MaxPool2D(pool_size=(2, 2))(conv10)
    BN5 = layers.BatchNormalization()(maxpool5)
    flatt = layers.Flatten()(BN5)

    #Final_Layers
    DropOut1 = layers.Dropout(rate=0.5)(flatt)
    FC1 = layers.Dense(units=256, activation='relu')(DropOut1)
    DropOut2 = layers.Dropout(rate=0.25)(FC1)
    FC2 = layers.Dense(units=2, activation='softmax')(DropOut2)
    #konec
    model = Model(inputs=i, outputs=FC2) #definice vstupu a vystupu modelu
    #model.summary() #udela vypis struktury do konzole

    #m = metrics.BinaryAccuracy(name="binary_accuracy",dtype=None, threshold=0.5) - zadny efekt
    opt = optimizers.Adam()
    model.compile(optimizer=opt, loss=['binary_crossentropy'], metrics="binary_accuracy")


    return model

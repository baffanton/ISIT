import numpy as np
from keras.models import Sequential
from keras.layers import Dense, Dropout, Flatten
from keras.layers.convolutional import Conv2D, MaxPooling2D
import tensorflow as tf
import scipy
from keras.preprocessing.image import ImageDataGenerator

datagen = ImageDataGenerator(rescale=1./255)
train_dir = r"dataset\train"
val_dir = r"dataset\val"
test_dir = r"dataset\test"
img_width=200
img_height=200
batch_size=20
input_shape = (img_width, img_height, 3)

train_generator = datagen.flow_from_directory(train_dir, target_size=(img_width, img_height), batch_size=batch_size, class_mode='categorical')
val_generator = datagen.flow_from_directory(val_dir, target_size=(img_width, img_height), batch_size=batch_size, class_mode='categorical')
test_generator = datagen.flow_from_directory(test_dir, target_size=(img_width, img_height), batch_size=batch_size, class_mode='categorical')

nb_train_samples = 10400
nb_validation_samples = 2880
nb_test_samples = 2000
epochs = 10

model = Sequential()
model.add(Conv2D(32, (3, 3), input_shape=input_shape, activation='relu')) 
model.add(MaxPooling2D(pool_size=(2, 2)))

model.add(Conv2D(32, (3, 3), activation='relu'))
model.add(MaxPooling2D(pool_size=(2, 2)))

model.add(Conv2D(64, (3, 3), activation='relu'))
model.add(MaxPooling2D(pool_size=(2, 2))) 
 
model.add(Flatten())
model.add(Dense(64, activation='relu')) 
model.add(Dropout(0.5)) 
model.add(Dense(4, activation='softmax'))

model.compile(loss='categorical_crossentropy', optimizer='adam', metrics=['accuracy'])

model.summary()
steps_train = nb_train_samples // batch_size
steps_val = nb_validation_samples // batch_size

model.fit(x=train_generator, steps_per_epoch=steps_train, epochs=epochs, validation_data=val_generator, validation_steps=steps_val)

steps_test = nb_test_samples // batch_size
scores = model.evaluate_generator(test_generator, steps_test)
print("Accuracy: %.2f%%" % (scores[1]*100))

model.save(r'model_dir')

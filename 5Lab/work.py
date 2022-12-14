import tensorflow as tf
from tensorflow import keras
from tensorflow.keras.utils import load_img
from tkinter import Tk
from tkinter.filedialog import askopenfilename
import numpy as np
from PIL import Image

#Загружаем модель
model = keras.models.load_model(r'model_dir')

#Составляем массив ответов
classes = np.array(['circle', 'square', 'star', 'triangle'])

answer = True
while (answer):
    #Открываем диалог для выбора файла
    Tk().withdraw()
    filename = askopenfilename(filetypes=[("PNG files", ".png"), ("JPEG files", ".jpeg .jpg")])

    #Изменяем размер изображения на 200х200 и конвертируем его в массив данных
    img = Image.open(filename)
    img = img.resize((200, 200))
    img = img.convert('RGB')
    image = np.array(img)
    images_list = []
    images_list.append(np.array(image))
    x = np.asarray(images_list)

    #Забиваем в нейросеть наше изображение
    predict_result = model.predict(x, verbose=2)

    #Выбираем лучшее значение из массива
    result_ind = np.argmax(predict_result)

    #Выводим ответ
    print('Image class: ' + classes[result_ind])

    one_more = input('Хотите проверить ещё какое-нибудь изображение?: ')
    if (one_more != "Да" and one_more != "Yes"):
        answer = False






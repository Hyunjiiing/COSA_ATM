import tensorflow as tf
import PIL
import numpy as np
from keras.preprocessing import image
from keras.utils import load_img, img_to_array, array_to_img
from keras.models import load_model

def classify_image(path):
    model = load_model('model.h5')
    test_img = load_img(path, target_size=(150, 150), interpolation='bilinear')
    x = img_to_array(test_img)
    x = np.expand_dims(x, axis=0)
    images = np.vstack([x])
    result = model.predict(images)

    return "not manhole" if result[0] else "manhole"
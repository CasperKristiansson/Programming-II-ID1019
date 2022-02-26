from PIL import Image
import os

for file in os.listdir():
    if '.ppm' in file:
        im = Image.open(file)
        im.save(f'{os.path.splitext(file)[0]}.jpg')
        os.remove(file)
        print(f'Saved: {file}')

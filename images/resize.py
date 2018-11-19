#!/usr/bin/python
from PIL import Image
import os, sys

path = "/home/aman/Desktop/Sem-5/CS-663/project/Image-Inpainting/images/"
dirs = os.listdir( path )

def resize():
    i=1
    for item in dirs:
        if os.path.isfile(path+item):
            if item == "resize.py":
                continue
            im = Image.open(path+item)
            f, e = os.path.splitext(path+item)
            imResize = im.resize((250,250), Image.ANTIALIAS)
            imResize.save(f + str(i)+'.jpg', 'JPEG', quality=90)

resize()
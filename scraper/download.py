import re
import os
import requests

# set path for download location
path = os.getcwd() + '\dataset'

# brand names
brands = [
    'armani',
    'audemarspiguet',
    'breitling',
    'cartier',
    'fossil',
    'gucci',
    'guess',
    'iwc',
    'jaegerlecoultre',
    'michaelkores',
    'movado',
    'omega',
    'panerai',
    'patekphilippe',
    'rolex',
    'seiko',
    'zenith'
]


def download_images(url, imageName):
    # downloads images
    r = requests.get(url)
    with open(imageName, 'wb') as outfile:
        outfile.write(r.content)


# for each brand
for brand in brands:
    # open link on each line
    with open('./links/{}.txt'.format(brand)) as f:
        # unique identifier for no same name
        unique = 1
        # for each line
        for line in f:
            # set name of the image
            link = line.split(',')[0]
            name = brand + "-" + str(unique)
            name = path + "\\" + name.replace('\n', '') + ".png"
            download_images(link, name)
            unique += 1
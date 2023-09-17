import pandas as pd
import numpy as np
import random as rnd
import googlemaps as gm

'''
latitude / longitude / address / photo / aging_count
'''

gmaps = gm.Client(key='AIzaSyAwaYLRQZq7r1rMSib6ShEbVwkWLnQm-NQ')

df = pd.DataFrame(
    {'Latitude': ['36.6206095'], \
     'Longitude': ['127.4578717'], \
     'Address': ['Cheongju Seowon-gu Gaesin-dong 145-5'], \
     'Photo': ['manhole000.jpg'], \
     'Aging_Cnt': ['13']})

i = 0
max_aging_count = 30
csv_row = 100

for i in range(csv_row):
    i += 1
    while 1:
        lat = rnd.uniform(35.0, 37.3)
        long = rnd.uniform(127.0, 129.0)
        g = gmaps.reverse_geocode((lat, long))
        g = g[0]['formatted_address']
        x = g.split(', ')
        if g[0] == '산' or x == ' ' or x == '':
            continue
        else:
            x.reverse()
            del x[0]
            address = ' '.join(s for s in x)
            if address == '':
                continue
            else:
                if '+' in address:
                    continue
                else:
                    break

    df.loc[i] = [f'{lat:.7f}', f'{long:.7f}', f'{address}', "manhole{0:03d}.jpg".format(i), f'{rnd.randrange(0, 30)}']

# print(df.head())

df.to_csv('sample.csv')
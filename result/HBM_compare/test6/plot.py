from unittest import FunctionTestCase
import pandas as pd
import numpy as np


Function = ['Copy', 'Scale', 'Add', 'Triad']
Channel_num = ['1', '2', '4', '8', '16', '32']
values = np.empty(shape=(4,6))



def check_string():
    i = 0
    j = 0
    for channel_num in Channel_num:
        with open(channel_num +'channel.txt') as temp_f:
            datafile = temp_f.readlines()
        for line in datafile:
            for name in Function:
                if name in line:
                    print(line)
                    values[j][i] = line[16:23]
                    j = j+1
                    
        i = i+1
        j = 0

check_string()

df = pd.DataFrame(values, index=Function, columns=Channel_num)
average = df.mean()
df.plot()

#average.plot(title = 'CPU1', xlable='Num_Channel', y= 'Bandwidth_avarage')
ax= average.plot(title='TimingsimpleCPU / 1_core / l1_cache / no_openMP / memmove')
ax.set_xlabel("HBM channel#")
ax.set_ylabel("BW (MB/s)")


import os
mypath = os.getcwd()

splitpath = os.path.split(mypath)
print(splitpath)
average.to_csv('../Average/test{splitpath[1]}.csv')

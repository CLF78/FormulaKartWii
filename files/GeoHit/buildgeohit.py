import os
from subprocess import call

geohitlist = ['GeoHitTableItem.txt', 'GeoHitTableItemObj.txt']

# Create GeoHit files
for geohit in geohitlist:
    call(['wszst', 'binary', geohit, '--dest=../Common'])

import os
import shutil
from subprocess import call

regionlist = ['e', 'f', 'g', 'i', 'j', 's']
geohitlist = ['GeoHitTableItem.bin', 'GeoHitTableItemObj.bin']
root = os.path.abspath('../..')

# Copy GeoHit files
for region in regionlist:
    for geohit in geohitlist:
        shutil.copy(geohit, 'Common_%s.d/%s' % (region.upper(), geohit.replace('Geo', 'Neo')))

# Remove them
for geohit in geohitlist:
    os.remove(geohit)

# Create szs files
call(['wszst', 'create', '*.d'])

# Copy created szs files
for region in regionlist:
    filename = 'Common_%s.szs' % region.upper()
    shutil.copy(filename, os.path.join(root, 'build/Riivo/fkw/Common_X'))
    shutil.copy(filename, os.path.join(root, 'build/ISO/fkw'))
    os.remove(filename)
    print('Copied %s!' % filename)

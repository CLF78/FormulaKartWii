import os
import shutil
from subprocess import call

regionlist = ['e', 'f', 'g', 'i', 'j', 'k', 'm', 'q', 's', 'u']
geohitlist = ['GeoHitTableItem.bin', 'GeoHitTableItemObj.bin']
bmglist = ['Common', 'Menu', 'Race']
bmglist2 = ['Number', 'StaffRoll']
root = os.path.abspath('../..')

# Copy GeoHit files
for region in regionlist:
    for geohit in geohitlist:
        shutil.copy(geohit, 'Common_%s.d/%s' % (region.upper(), geohit.replace('Geo', 'Neo')))

    shutil.copy('cesso.brres', 'Common_%s.d' % region.upper())

# Copy BMGs
for region in regionlist:

    # Assemble folder name
    foldername = 'Common_%s.d' % region.upper()
    print('Processing %s...' % foldername)

    # Create message folder if it doesn't exist
    os.makedirs('%s/message' % foldername, exist_ok=True)

    # Copy BMGs
    for bmg in bmglist:
        shutil.copy('%s_%s.bmg' % (bmg, region.upper()), '%s/message/%s.bmg' % (foldername, bmg))

    # Copy more BMGs
    for bmg in bmglist2:
        shutil.copy('%s.bmg' % bmg, '%s/message/%s.bmg' % (foldername, bmg))

# Create szs files
call(['wszst', 'create', '*.d'])

# Copy created szs files
for region in regionlist:
    filename = 'Common_%s.szs' % region.upper()
    shutil.copy(filename, os.path.join(root, 'build/Riivo/fkw/Common_X'))
    shutil.copy(filename, os.path.join(root, 'build/ISO/fkw'))
    os.remove(filename)
    print('Copied %s!' % filename)

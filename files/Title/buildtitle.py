import os
import shutil
from subprocess import call

regionlist = ['e', 'j', 'k']
version = 'version'
root = os.path.abspath('../..')

# Encode image
call(['wimgt', 'encode', '%s.png' % version, '--transform=TPL.IA4', '--dest=%s.tpl' % version, '-o'])

# Copy texture in all szs files
for region in regionlist:

    # Assemble folder name
    foldername = 'Title_%s.d' % region.upper()
    print('Processing %s...' % foldername)

    # Copy texture
    shutil.copy('%s.tpl' % version, '%s/title/timg' % foldername)
    print('Assembled %s!' % foldername)

# Remove TPL
os.remove('%s.tpl' % version)

# Create szs files
call(['wszst', 'create', '*.d'])

# Copy created szs files
for region in regionlist:
    filename = 'Title_%s.szs' % region.upper()
    shutil.copy(filename, os.path.join(root, 'build/Riivo/fkw/Title_X'))
    shutil.copy(filename, os.path.join(root, 'build/ISO/fkw'))
    os.remove(filename)
    print('Copied %s!' % filename)

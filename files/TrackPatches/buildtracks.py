import os
import shutil
from subprocess import call

root = os.path.abspath('../..')

# Create szs files
call(['wszst', 'create', '*.d'])

# Get list of szs files
filelist = [file for file in os.listdir() if file.endswith('.szs')]

# Copy created szs files
for filename in filelist:
    shutil.copy(filename, os.path.join(root, 'build/Riivo/fkw/TrackPatches'))
    shutil.copy(filename, os.path.join(root, 'build/ISO/fkw/tracks'))
    os.remove(filename)
    print('Copied %s!' % filename)

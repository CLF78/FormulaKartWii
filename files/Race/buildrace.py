import os
import shutil
from subprocess import call

regionlist = ['e', 'f', 'g', 'i', 'j', 'k', 'm', 'q', 's', 'u']
itemlist = ['banana', 'bill', 'blue', 'bomb', 'feather', 'fib', 'golden', 'green', 'mega', 'pow', 'red', 'shock', 'star']
tpllist = ['feather', 'tt_d_number_3d_none']
ctrlist = ['fap_number', 'stem_window_new']
dt = ['d', 't']
root = os.path.abspath('../..')

# Copy new files
for region in regionlist:

    # Assemble folder name
    foldername = 'Race_%s.d' % region.upper()
    print('Processing %s...' % foldername)

    # Create ctrl folder in game_image if it doesn't exist
    os.makedirs('%s/game_image/ctrl' % foldername, exist_ok=True)

    # Item textures
    for prefix in dt:
        for item in itemlist:
            file = '%s-%s.tpl' % (prefix, item)
            if os.path.isfile(file):
                shutil.copy(file, '%s/game_image/timg' % foldername)

    # Other TPLs in game_image
    for tpl in tpllist:
        shutil.copy('%s.tpl' % tpl, '%s/game_image/timg' % foldername)

    # stem.brlyt
    shutil.copy('stem.brlyt', '%s/game_image/blyt' % foldername)

    # game_image_lap.brlyt
    shutil.copy('game_image_lap_%s.brlyt' % region.upper(), '%s/game_image/blyt/game_image_lap.brlyt' % foldername)

    # game_image_lap_texture_pattern_0_9.brlan
    shutil.copy('game_image_lap_texture_pattern_0_9.brlan', '%s/game_image/anim' % foldername)

    # BRCTR files
    for ctr in ctrlist:
        shutil.copy('%s.brctr' % ctr, '%s/game_image/ctrl' % foldername)

    # Race.bmg
    shutil.copy('Race_%s.bmg' % region.upper(), '%s/message/Race.bmg' % foldername)
    print('Assembled %s!' % foldername)

# Create szs files
call(['wszst', 'create', '*.d'])

# Copy created szs files
for region in regionlist:
    filename = 'Race_%s.szs' % region.upper()
    shutil.copy(filename, os.path.join(root, 'build/Riivo/fkw/Race_X'))
    shutil.copy(filename, os.path.join(root, 'build/ISO/fkw'))
    os.remove(filename)
    print('Copied %s!' % filename)

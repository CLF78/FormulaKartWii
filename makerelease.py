import os
from subprocess import run
from shutil import copy

arcname = 'FKWii'
isoname = '%s_ISO_Patcher.zip' % arcname
isoname2 = isoname.replace('_', ' ')
regionlist = ['P', 'E', 'J', 'K']

try:
    # Build files and code
    run(['python', 'buildgeohit.py'], cwd='files/GeoHit')
    run(['python', 'buildcommon.py'], cwd='files/Common')
    run(['python', 'buildrace.py'], cwd='files/Race')
    run(['python', 'buildtitle.py'], cwd='files/Title')
    run(['python', 'buildtracks.py'], cwd='files/TrackPatches')
    run(['python', 'make.py', '--no-debug'], cwd='src')

    # Copy code
    for region in regionlist:
        copy('src/bin/FormulaKartWii%s.bin' % region, 'build/Riivo/fkw/fkw')
        copy('src/bin/FormulaKartWii%s.bin' % region, 'build/ISO/fkw/code')
        copy('src/bin/Loader%s.bin' % region, 'build/Riivo/fkw')
        copy('src/bin/Loader%s.bin' % region, 'build/ISO/fkw')
        print('Copied %s!' % region)

    # Create zips
    run(['7z', 'a', '-mx=9', '%s.zip' % arcname, './build/Riivo/*'])
    run(['7z', 'a', '-mx=9', isoname, './build/ISO/*'])

    # Ugly workaround because 7z doesn't like files with spaces
    if os.path.isfile(isoname2):
        os.remove(isoname2)
    os.rename(isoname, isoname2)

    # All done!
    print('Built all!')
except:
    print('Build failed!')

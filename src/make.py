import os
import sys
from shutil import rmtree
from subprocess import call
from elftools.elf.elffile import ELFFile as elf

# Locate various things
gcc = 'powerpc-eabi-gcc'
objcopy = 'powerpc-eabi-objcopy'
destdir = 'bin'

# Initialize variables
debug = False
regionlist = ['P', 'E', 'J', 'K']
startHook = 0x8000629C
startFuncName = 'start'

def build(isBootStrap):

    # Initialize vars
    if isBootStrap:
        mainpath = 'bootstrap'
        outname = 'Loader'
        buildtype = 'bootstrap'
    else:
        mainpath = 'src'
        outname = 'FormulaKartWii'
        buildtype = 'payload'

    # Pretty print
    print('Building %s...' % buildtype)

    # Get all files in the source folder
    filelist = [os.path.join(root, item) for root, subfolder, files in os.walk(mainpath) for item in files if item.lower().endswith('.s') or item.lower().endswith('.c')]

    for region in regionlist:
        # Assemble destination file
        outputfile = '%s/%s%s.' % (destdir, outname, region)

        # Initialize GCC command
        cc_command = [gcc, '-Iinclude', '-nostdlib', '-D', 'REGION_%s' % (region), '-D', 'REGION=\'%s\'' % region, '-Os', '-Wl,-T,%s/mem.ld,-T,rmc.ld,-T,rmc%s.ld' % (mainpath, region.lower())]

        # Add debug macro if debug is on
        if debug:
            cc_command += ['-D', 'DEBUG']

        # Add all cpp files and the destination
        cc_command += filelist
        cc_command += ['-o', outputfile + 'o']

        # Debug output for testing:
        # print(*cc_command)

        # Call GCC to compile everything
        c = call(cc_command)
        if c != 0:
            print('Build failed!')
            return

        # Get offset to start function
        if isBootStrap:
            with open(outputfile + 'o', 'rb') as f:
                startFunc = elf(f).get_section_by_name('.symtab').get_symbol_by_name(startFuncName)[0].entry['st_value']
            instruction = (((startFunc-startHook) & 0x3FFFFFF ) | 0x48000000)
            print('Hook instruction is', hex(instruction))

        c = call([objcopy, '-O', 'binary', '-R', '.eh_frame', '-R', '.eh_frame_hdr', outputfile + 'o', outputfile + 'bin'])
        if c != 0:
            print('Build failed!')
            return
        else:
            print('Built %s!' % region)

    # We're done!
    print('All built!')

def main():
    # Debug prompt
    global debug
    
    if len(sys.argv) > 1:
        debug = not (sys.argv[1] == '--no-debug')
    else:
        debug = input('Enable debug mode? (Y/N): ').lower() == 'y'

    # Make a clean build folder
    if os.path.isdir(destdir):
        rmtree(destdir)
    os.mkdir(destdir)

    # Build it!
    build(False)
    build(True)

main()

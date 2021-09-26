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
excludefile = 'excludes.txt'
extensions = ['.s', '.S', '.c']

def build(isBootStrap: bool):

    # Initialize vars
    if isBootStrap:
        mainpath = 'bootstrap'
        outname = 'Loader'
    else:
        mainpath = 'src'
        outname = 'FormulaKartWii'

    # Pretty print
    print('Building', 'bootstrap...' if isBootStrap else 'payload...')

    # Get excluded files
    with open(excludefile) as f:
        excludes = [line.rstrip() for line in f.readlines()]

    # Get all files in the source folder
    filelist = [os.path.join(root, item) for root, s, files in os.walk(mainpath) for item in files if item not in excludes and os.path.splitext(item)[1] in extensions]

    for region in regionlist:
        # Assemble destination file
        outputfile = f'{destdir}/{outname}{region}.'

        # Initialize GCC command
        cc_command = [gcc, '-Iinclude', '-pipe', '-nostdlib', '-D', f'REGION_{region}', '-Os', f'-Wl,-T,{mainpath}/mem.ld,-T,rmc.ld,-T,rmc{region.lower()}.ld']

        # Add debug macro if debug is on
        if debug:
            cc_command += ['-D', 'DEBUG']

        # Add all cpp files and the destination
        cc_command += filelist
        cc_command += ['-o', outputfile + 'o']

        # Debug output for testing
        # print(*cc_command)

        # Call GCC to compile everything
        c = call(cc_command)
        if c != 0:
            print('Build failed!')
            continue

        # Get offset to start function
        if isBootStrap:
            with open(outputfile + 'o', 'rb') as f:
                startFunc = elf(f).get_section_by_name('.symtab').get_symbol_by_name(startFuncName)[0]['st_value']
            instruction = (((startFunc-startHook) & 0x3FFFFFC) | 0x48000000)
            print('Hook instruction is', hex(instruction))

        # Convert to binary
        c = call([objcopy, '-O', 'binary', outputfile + 'o', outputfile + 'bin'])
        if c != 0:
            print('Build failed!')
        else:
            print(f'Built {region}!')

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

    # We're done!
    print('Built all!')

main()

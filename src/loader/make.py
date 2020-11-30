import os
from subprocess import call
from shutil import rmtree
from elftools.elf.elffile import ELFFile as elf

# Locate executables and initialize variables
devkitppc = 'C:/Users/CLF78/Desktop/Mod Development/Development/Kamek/tools/devkitPPC/bin'
asm = os.path.join(devkitppc, 'powerpc-eabi-as')
gcc = os.path.join(devkitppc, 'powerpc-eabi-gcc')
objcopy = os.path.join(devkitppc, 'powerpc-eabi-objcopy')
dataStart = 0x80258700
hook = 0x8000629C  # patch end of __init_cpp_exceptions
section = 15

# Make build folder
if not os.path.exists('build'):
    os.mkdir('build')

# Determine region
while True:
    region = input('Choose Region: ').lower()
    if region == 'e' or region == 'p' or region == 'j' or region == 'k':
        region = 'rmc' + region
        break
    else:
        print('Invalid input')

# Determine codespace
while True:
    codespace = input('Code Space: ')
    try:
        codespace = int(codespace, 16)
        if codespace % 4 != 0:
            codespace += 4 - codespace % 4
        codespace = hex(codespace)
        break
    except:
        print('Invalid input')

# Stuff
print('GCT Address:', hex(0x817F0520 - int(codespace, 16)))
with open('build/temp.ld', 'w') as f:
    f.write('MEMORY { MEM (rwx): ORIGIN = %s, LENGTH = %s }' % (dataStart, 0x10000))

# Compile the code
call([asm, "-mregnames", '--defsym', 'CODESPACE='+codespace, 'src/codehandler.s', '-o', 'build/codehandler.o'])
call([gcc, '-nostartfiles', '-D', 'CODESPACE='+codespace, '-Os', '-Wl,-T,{}.ld,-T,build/temp.ld'.format(region), '-ffunction-sections', '-fdata-sections', 'src/main.c', 'src/include.c', 'build/codehandler.o', '-o', 'build/loader.o'])
call([objcopy, '-O', 'binary', '-R', '.eh_frame', '-R', '.eh_frame_hdr', 'build/loader.o', 'loader.bin'])

# Patch the XML
with open('build/loader.o', 'rb') as f, open('base.xml') as g, open('{}.xml'.format(region), 'w') as h:
    elfData = elf(f)
    symtab = elfData.get_section_by_name('.symtab')
    startFunc = symtab.get_symbol_by_name('_start')[0].entry['st_value']
    instruction = (((startFunc-hook) & 0x3FFFFFF ) | 0x48000000)
    print('New instruction is', hex(instruction))
    h.write(g.read().format(hex(dataStart), hex(hook), hex(instruction)[2:]))
rmtree('build')

# Ask whether the user wants to patch a DOL, exit otherwise
yesdol = input('Patch DOL? (Y/N) ').lower()
if not yesdol == 'y':
    exit()

# Locate DOL file
while True:
    dol = input('DOL File: ')
    if os.path.isfile(dol):
        break
    else:
        print('File does not exist')

# Begin patch
with open(dol, 'rb') as f, open('loader.bin', 'rb') as g:
    dolData = bytearray(f.read())
    dolLength = len(dolData)
    loaderData = bytearray(g.read())
    loaderLength = len(loaderData)

# Add new code
dolData.extend(loaderData)

# Set patch address
sectionOffset = int.from_bytes(dolData[0:4], 'big')
sectionRamOffset = int.from_bytes(dolData[0x48:0x4C], 'big')
patchAddr = hook + sectionOffset - sectionRamOffset
dolData[patchAddr:patchAddr+4] = bytearray(instruction.to_bytes(4, byteorder='big')) # b 0x802c0000

# Patch the header
dolData[section*4:(section*4)+4] = bytearray(dolLength.to_bytes(4, byteorder='big')) # section offset
dolData[(section*4)+0x48:(section*4)+0x4c] = bytearray(dataStart.to_bytes(4, byteorder='big')) # data offset
dolData[(section*4)+0x90:(section*4)+0x94] = bytearray(loaderLength.to_bytes(4, byteorder='big')) # section length

# Save the resulting file
with open('main{}.dol'.format(region[3:]), 'wb') as f:
    f.write(bytes(dolData))

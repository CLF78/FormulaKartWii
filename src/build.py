import os
import shutil
import subprocess
import yaml

buildfile = 'build\\OnlineEndurance{}.txt'
modulefolder = 'codes'
tempfolder = 'tmp'
pyasmiipath = 'C:\\Program Files\\pyiiasmh-4.1.5\\pyiiasmh.exe'
codetypeslist = ['0414', '0616', 'C0', 'C2D2', 'F2F4', 'RAW']
currtmp = 0


def writeToFile(filestr, name, region):
    with open(buildfile.format(region), 'a') as f:
        thinglist = [filestr, '']
        if name:
            thinglist = ['', name] + thinglist

        f.write('\n'.join(thinglist))


def doCode(filestr, name, addr, codetype, region):
    global currtmp

    # Address sanity check
    customaddr = 0x80000000 <= addr <= 0x817FFFFF

    # Codetype sanity check
    codetype = codetype.upper()
    customtype = codetype in codetypeslist

    # If it's a compiled code, write it right away
    if codetype == 'COMPILED':
        # Strips anything other than code from compiled code lines
        filestr = '\n'.join([line[:17] for line in filestr.splitlines()])

        # Write to the file
        writeToFile(filestr, name, region)
        print('Built!')
    elif codetype == 'NOP':
        filestr = '0' + hex(addr - 0x80000000 + 0x4000000)[2:] + ' 60000000'
        writeToFile(filestr.upper(), name, region)
        print('Built!')
    elif codetype == 'BLR':
        filestr = '0' + hex(addr - 0x80000000 + 0x4000000)[2:] + ' 4E800020'
        writeToFile(filestr.upper(), name, region)
        print('Built!')
    elif codetype == 'DATA':
        filestr = '0' + hex(addr - 0x80000000 + 0x4000000)[2:] + ' ' + filestr
        writeToFile(filestr.upper(), name, region)
    else:
        # Write to a temp file
        path = os.path.join(tempfolder, str(currtmp) + '.S')
        with open(path, 'w') as f:
            f.write('.set REGION, ')
            f.write('\''.join(['', region, '\n']))
            f.write(filestr)

        # Set up the command
        command = [pyasmiipath, path, 'a', '--formalnames']
        if customtype:
            command.append('--codetype='+codetype)

        if customaddr:
            command.append('--bapo='+hex(addr)[2:])

        if codetype == 'C0':
            command.append('--rmfooterasm')

        # Run PyiiASMH
        out = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

        # Parse the output
        code = '\n'.join(out.stdout.decode('utf-8').splitlines()[2:-2])

        # Make sure there was no error
        try:
            a = int(code[:8], 16)
            writeToFile(code.upper(), name, region)
            print('Built!')
        except:
            print('Build failed!', code)

        # Increase tmp file number, for debugging
        currtmp += 1


def doProjectFile(project):
    # Check for the required field
    if 'regions' not in project or 'modules' not in project:
        print('Required fields are missing!')
        return

    # Recreate the temp folder
    if os.path.isdir(tempfolder):
        shutil.rmtree(tempfolder)
    os.mkdir(tempfolder)

    # Recreate the build folder
    if not os.path.isdir('build'):
        os.mkdir('build')

    # Compile each module
    print('Beginning compilation...')
    for i, region in enumerate(project['regions']):
        print('Compiling region', region)

        # Write the game id and name
        with open(buildfile.format(region), 'w') as f:
            f.write('RMC{}01\n'.format(region))
            f.write('Mario Kart Wii\n')

        # Begin parsing modules
        for module in project['modules']:

            # Set some stuff
            codename = module['name'] if 'name' in module else ''
            print('Parsing', codename)

            thing = 'addr_' + region.lower()
            injectionaddr = module[thing] if thing in module else 0
            codetype = module['type'] if 'type' in module else ''

            # Open the file specified by the module
            if 'src' in module:
                file = os.path.join(modulefolder, module['src'])
                with open(file) as g:

                    # Read the file line by line, and parse special lines
                    filechunk = ''
                    ignore = False
                    line = g.readline()
                    while line:
                        if line.startswith('#ENDCODE'):
                            if not ignore:
                                doCode(filechunk.strip(), codename, injectionaddr, codetype, region)
                                codename = ''
                            filechunk = ''
                            ignore = False
                        elif line.startswith('#INJECT'):
                            injectionaddr = int(line.removeprefix('#INJECT').strip().split(', ')[i], 16)
                        elif line.startswith('#SETTYPE'):
                            codetype = line.removeprefix('#SETTYPE').strip().upper()
                        elif line.startswith('#SETREGION'):
                            line = line.removeprefix('#SETREGION').strip()
                            if line != region:
                                ignore = True
                        else:
                            filechunk += line
                        line = g.readline()
            elif 'data' in module:
                doCode(module['data'].strip(), codename, injectionaddr, 'DATA', region)
            else:
                doCode('', codename, injectionaddr, codetype, region)
    print('All done!')


def main():
    # Open the project file
    with open('project.yaml') as f:
        f = yaml.safe_load(f.read())

    # Parse it
    doProjectFile(f)


main()

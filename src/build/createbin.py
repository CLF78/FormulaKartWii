import os

basepath = 'C:\\Users\\CLF78\\Desktop\\FKW\\build\\%s\\fkw\\codes'
for file in os.listdir(basepath % 'Riivo'):
    letter = file[3].lower()
    with open(os.path.join(basepath % 'Riivo', file), 'rb') as f, open(os.path.join(basepath % 'ISO', 'main%s.bin' % letter), 'wb') as g:
        bytez = f.read(4)
        while bytez.hex() != '280016ba':
            g.write(bytez)
            bytez = f.read(4)
    print('Processed', file)

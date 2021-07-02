.include "asm_setup.S"

.set StartFunc, 0x808DD400

.global runPayload, filename, fatalstring

runPayload:
lis r3, StartFunc@ha
lwz r3, StartFunc@l(r3)
mtctr r3
bctr

filename:
.string "/fkw/FormulaKartWii%c.bin"

fatalstring:
.string "Could not find Formula Kart Wii payload.\nPlease check that your installation is correct."

.align 2

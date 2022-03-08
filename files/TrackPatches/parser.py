import struct
import os
import zlib

"""
HOW TO USE:
- Extract the original track szs in the 'og' folder using wszst
- Place the patched KMP file in the 'patches' folder, name it the same as the szs file
- Run this script
- The patched KMP will be placed in the 'final' folder, and it will be automatically renamed
"""

ogDir = 'og'
ogDest = '.d'
patchDir = 'patches'
kmpFile = 'course.kmp'
kmpMagic = 'RKMD'
importantSections = ['ITPT', 'ITPH', 'CKPT', 'CKPH', 'AREA', 'JGPT']
enptMagic = 'ENPT'

def parseFile(root):
	print('Parsing', root + '...')
	with open(os.path.join(ogDir, root + ogDest, kmpFile), 'rb') as og, open(os.path.join(patchDir, root + '.kmp'), 'rb') as patch:

		# Get section count and header size for both files
		og.seek(8)
		patch.seek(8)
		sectionCount, headerSize = struct.unpack('>HH', og.read(4))
		altSectionCount, altHeaderSize = struct.unpack('>HH', patch.read(4))

		# Default CRC to 0
		crc = 0

		# Parse all sections to get ENPT offset
		for i in range(sectionCount):

			# Reset position
			og.seek(16 + 4 * i)

			# Get offset for this section and the next one
			secOff, nextSecOff = struct.unpack('>II', og.read(8))

			# Failsafe for final section
			if i == sectionCount - 1:
				og.seek(0, 2)
				nextSecOff = og.tell()

			# Get section
			og.seek(headerSize + secOff)

			# Check magic
			magic = og.read(4).decode()
			if magic == enptMagic:

				# Go forwards 4 bytes
				og.seek(4, 1)

				# Calculate CRC
				crc = zlib.crc32(og.read(nextSecOff - secOff - 8))
				print('Found ENPT section!, CRC =', hex(crc))
				break

		# Return if ENPT was not found
		if crc == 0:
			print('ENPT not found, skipping...')
			return

		# Initialize variables
		finalSecOffs = []
		finalSecs = []

		# Go to the section offsets for each file
		for i in range(altSectionCount):

			# Reset position
			patch.seek(16 + 4 * i)

			# Get offset for this section and the next one
			altSecOff, altNextSecOff = struct.unpack('>II', patch.read(8))

			# Failsafe for final section
			if i == altSectionCount - 1:
				patch.seek(0, 2)
				altNextSecOff = patch.tell()

			# Get section
			patch.seek(altHeaderSize + altSecOff)

			# Check magic
			altMagic = patch.read(4).decode()
			if altMagic in importantSections:

				# Reset section offset
				patch.seek(-4, 1)

				# Initialize
				secFound = False

				# Find the equivalent section offset
				for j in range(sectionCount):

					# Reset position
					og.seek(16 + 4 * j)

					# Get offset for this section and the next one
					secOff, nextSecOff = struct.unpack('>II', og.read(8))

					# Failsafe for final section
					if j == sectionCount - 1:
						og.seek(0, 2)
						nextSecOff = og.tell()

					# Get section
					og.seek(headerSize + secOff)

					# Check magic
					magic = og.read(4).decode()
					if magic == altMagic:

						# Reset section offset and break
						og.seek(-4, 1)
						secFound = True
						break

				# If section was not found, skip it
				if not secFound:
					continue

				# Else compare them
				sec = og.read(nextSecOff - secOff)
				altSec = patch.read(altNextSecOff - altSecOff)

				# If not equal, set for writing
				if sec != altSec:
					if finalSecOffs:
						finalSecOffs.append(finalSecOffs[-1] + len(finalSecs[-1]))
					else:
						finalSecOffs.append(0)
					finalSecs.append(altSec)
					print('Found differing section', altMagic + '!')

		# If no differing sections are found, skip
		if not finalSecs:
			print('No differing sections found! Skipping patch...')
			return

		# Write the new file
		with open(hex(crc)[2:].upper() + '.kmp', 'wb') as dest:
			finalSecCount = len(finalSecs)
			finalHeaderLength = 16 + 4 * finalSecCount
			finalFileSize = finalHeaderLength + sum(map(len, finalSecs))
			dest.write(kmpMagic.encode())
			dest.write(struct.pack('>IHHI', finalFileSize, finalSecCount, finalHeaderLength, 2520))
			dest.write(struct.pack('>' + 'I' * finalSecCount, *finalSecOffs))
			for i in finalSecs:
				dest.write(i)

def main():
	# Walk through all subdirectories
	for root in os.listdir(ogDir):
		parseFile(root[:-2])

main()

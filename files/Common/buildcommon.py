import os
from subprocess import run

regionlist = ['E', 'F', 'G', 'I', 'J', 'K', 'S']
extrafiles = ['cesso.brres', 'NeoHitTableItem.bin', 'NeoHitTableItemObj.bin']

def main():
	for region in regionlist:
		for file in extrafiles:
			os.link(os.path.join('Global', file), os.path.join(region, file))
		run(['wszst', 'create', '--szs', region, '--dest', f'Common_{region}.szs', '-o'])
		for file in extrafiles:
			os.unlink(os.path.join(region, file))

if __name__ == '__main__':
	main()

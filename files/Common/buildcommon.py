import os
from subprocess import run

regionlist = ['E', 'F', 'G', 'I', 'J', 'K', 'S']
extrafiles = ['castleballoon1.brres', 'cesso.brres', 'M_obj_start.brres', 'Mstand.brres', 'NeoHitTableItem.bin', 'NeoHitTableItemObj.bin', 'volfall.brres', 'v_stand1.brres', 'v_stand2.brres']

def main():
	for region in regionlist:
		for file in extrafiles:
			os.link(os.path.join('Global', file), os.path.join(region, file))
		run(['wszst', 'create', '--szs', region, '--dest', f'Common_{region}.szs', '-o'])
		for file in extrafiles:
			os.unlink(os.path.join(region, file))

if __name__ == '__main__':
	main()

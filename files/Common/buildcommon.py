from subprocess import run

regionlist = ['E', 'F', 'G', 'I', 'J', 'K', 'S']

def main():
	print('Building UI assets...')
	run(['wszst', 'create', '--szs', 'Global', '--dest', 'PatchCommon.szs', '-o'])
	for region in regionlist:
		run(['wszst', 'create', '--szs', region, '--dest', f'Common_{region}.szs', '-o'])

if __name__ == '__main__':
	main()
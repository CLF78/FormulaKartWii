import os

cwd = os.getcwd()
languages = ["E", "F", "G", "I", "J", "K", "M", "Q", "S", "U"]


for language in languages:
    lace = os.path.join(cwd, language, "message", "Lace.txt")
    manu = os.path.join(cwd, language, "message", "Manu.txt")
    
    os.system(f"wbmgt encode \"{lace}\" -o")
    os.system(f"wbmgt encode \"{manu}\" -o")
    os.system(f"del \"{lace}\"")
    os.system(f"del \"{manu}\"")

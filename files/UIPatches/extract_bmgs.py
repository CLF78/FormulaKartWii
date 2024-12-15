import os

cwd = os.getcwd()
languages = ["E", "F", "G", "I", "J", "K", "M", "Q", "S", "U"]


for language in languages:
    lace = os.path.join(cwd, language, "message", "Lace.bmg")
    manu = os.path.join(cwd, language, "message", "Manu.bmg")
    
    os.system(f"wbmgt decode \"{lace}\"")
    os.system(f"wbmgt decode \"{manu}\"")

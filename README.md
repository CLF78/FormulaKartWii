This repo contains the source code for the Formula Kart Wii mod for Mario Kart Wii.

# How to build FKW (Windows)
* Install the following programs and __add them to PATH__
  * [7-zip](https://www.7-zip.org/)  
  * [devkitPPC r33](https://wii.leseratte10.de/devkitPro/devkitPPC/r33%20%282018%29/)
  * [Python](https://www.python.org/downloads/)
  * [Wiimms SZS Tool](https://szs.wiimm.de/download.html)
* Run `python -m pip install pyelftools` in a terminal anywhere to install `pyelftools`
* Gather all Mario Kart Wii's original track files with the `.szs` extension (we can't include them ourselves)
  * Move them to `files/TrackPatches/og` and open a terminal in that folder
  * Run `wszst extract *.szs` in that terminal
  * You can now delete the `.szs` files if you like
* Run `python .\buildrelease.py` in a terminal opened to the root of this repo to build the mod!

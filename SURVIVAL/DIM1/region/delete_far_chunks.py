#!/usr/bin/env python3

# This script manages chunks in the end that are very far away.
# This keeps end busting fun and feasible.

from pathlib import Path
import os

threshold = 20

end = Path('/home/billiam/Minecraft-Server/SURVIVAL/DIM1/region')

def skip_message(file: Path):
    return 'Skipping file ' + file.name + ' as it is improperly named.'

for rfile in end.iterdir():
    
    # Ensures it's an mca file
    if not (rfile.name.endswith('.mca') and rfile.is_file()):
        continue

    fullname = rfile.name.split('.')

    # Skip and warn if incorrect length
    if len(fullname) != 4:
        print(skip_message(rfile))
        continue

    r, x_str, z_str, mca = fullname

    # Skip and warn if incorrectly named
    if not (r == 'r' and mca == 'mca'):
        print(skip_message(rfile))
        continue

    # Number check
    try:
        x = int(x_str)
        z = int(z_str)
    except ValueError:
        print(skip_message(rfile))
        continue

    if abs(x) > threshold or abs(z) > threshold:
        print('Deleting ' + rfile.name)
        os.remove(rfile)

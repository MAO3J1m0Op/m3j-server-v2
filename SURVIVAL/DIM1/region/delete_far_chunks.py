#!/usr/bin/env python3

# This script manages chunks in the end that are very far away.
# This keeps end busting fun and feasible.

from pathlib import Path
import os
import random
from sys import argv

fallback_theshold = 20
# Gets threshold as first argument
try:
    # One number, constant
    threshold = int(argv[1])
except ValueError:
    # Tries a random set, split at :
    bounds = argv[1].split(':')

    # There must be only 1 colon
    if len(bounds) == 2:
        try:
            threshold = tuple(int(i) for i in bounds)
        except ValueError:
            print('Supplied theshold is invalid. Assuming ' + str(fallback_theshold))
            threshold = fallback_theshold
    else:
        print('Supplied theshold is invalid. Assuming ' + str(fallback_theshold))
        threshold = fallback_theshold

except IndexError:
    print('No threshold supplied. Assuming ' + str(fallback_theshold))
    threshold = fallback_theshold

# If threshold is a tuple, randomly pick 1 number in bounds
if type(threshold) is tuple:
    low, high = threshold
    threshold = random.randint(low, high)

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
        # print('Deleting ' + rfile.name)
        os.remove(rfile)

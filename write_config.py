#!/usr/bin/env python3

import os
import plistlib

print("Writing Reposado Config...")

with open('/reposado/code/preferences.plist', 'rb') as f:
    plist = plistlib.loads(f.read())

for key in [e for e in os.environ if e.startswith('REPOSADO_')]:
    val = os.environ[key]
    pkey = key.replace('REPOSADO_', '')
    print("Applying {} = {}".format(pkey, val))
    plist[pkey] = val

with open('/reposado/code/preferences.plist', 'wb') as f:
    plistlib.dump(plist, f)

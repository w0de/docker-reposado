import os
import plistlib

with open('/reposado/code/preferences.plist', 'rb') as f:
    plist = plistlib.loads(f.read())

for key in [e for e in os.environ if e.startswith('REPOSADO_')]:
    plist[key.replace('REPOSADO_', '')] = os.environ[key]

with open('/reposado/code/preferences.plist', 'wb') as f:
    plistlib.dump(plist, f)

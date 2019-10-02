#!/bin/bash

# Run with care:
# Adds all non-deprecated and removes all deprecated from all catalogs

/reposado/code/repo_sync

for catalog in $(/reposado/code/repoutil --catalogs); do
  /reposado/code/repoutil --remove-product deprecated $catalog
  /reposado/code/repoutil --add-product non-deprecated $catalog
done

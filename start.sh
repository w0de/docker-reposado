#!/bin/bash

/reposado/code/repo_sync
service nginx start 
python /home/app/margarita/run.py runserver

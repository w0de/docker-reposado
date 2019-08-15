#!/bin/bash

service nginx start &
python /home/app/margarita/run.py runserver &

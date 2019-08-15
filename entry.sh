#!/bin/bash

/sbin/my_init & 
service nginx start &
python /home/app/margarita/run.py runserver &

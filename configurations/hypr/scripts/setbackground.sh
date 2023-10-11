#!/bin/bash

swww query || swww init
wallpaper="/home/dreadster/Pictures/nyarch.png"

swww img --transition-type grow --transition-pos top-right --transition-duration 2 --transition-fps 60 $wallpaper 
# swww img $wallpaper

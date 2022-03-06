#!/bin/bash

echo ""

echo -e "\nbuild docker hadoop image\n"
sudo docker build -t livebug/hadoop:3.3.0-a .

echo ""
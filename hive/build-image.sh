#!/bin/bash

echo ""

echo -e "\nbuild docker hadoop image\n"
sudo docker build -t livebug/hive:3.1.2 .

echo ""
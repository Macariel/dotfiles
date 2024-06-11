#!/bin/bash - 
# Touchscreen sometimes moves and clicks the mouse erractically
xinput disable $(xinput | grep ELAN | awk '{print $5}' | grep -oP "id=\K[0-9]+")

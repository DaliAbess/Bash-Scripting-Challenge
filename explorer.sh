#!/bin/bash
# Part 1: File and Directory Exploration
echo "Files and Directories in the Current Path: "
ls -s
echo "Character Counting: "
while true;do
read -p "Enter a line of text: " line
if [ -z "$line" ] ; then
echo "Exiting the Interactive Explorer. Goodbye!"
break 
fi
Character_Count=$(echo -n "$line" | wc -m)
echo "charcter count =${Character_Count}."
done


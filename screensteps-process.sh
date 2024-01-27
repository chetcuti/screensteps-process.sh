#!/bin/bash
# A bash script used to do some post-processing on HTML files exported by ScreenSteps Desktop
# v2.9.6 Build 3 to make them more SEO-friendly. It may or may not work with other versions.
#
# USAGE: Change the "fileextension" variable to the extension that you have ScreenSteps export
# in. Then just run this script in the directory with your documentation (you can also move the
# script somewhere in your PATH, but you still need to execute it from your documents folder).
#
# NOTE: Since this script was created to help with SEO, it only works if you have your lessons
# output to the same folder as your table of contents (that is, if the ToC is in / and your
# lessons are in /lessons/, it won't work).
#
# This script:
# - Changes all filenames from uppercase to lowercase
# - Changes instances of multiple dashes to single dashes
# - Removes any dashes that appear at the end of the filename (before the extension)
# - Converts apostrophe'd words to be more human and SEO friendly (they-re- becomes theyre-)
# - Does a search and replace in all files, updating the old filenames to the new filenames

fileextension="php"

for file in *.$fileextension
do
    #Check to see if the filename contains any uppercase characters
    iscap=`echo $file | awk '{if ($0 ~ /[[:upper:]]/) print }'`
    if [[ -n $iscap ]]
    then
        #If the filename contains upper case characters convert them to lower case
        newname=`echo $file | tr '[A-Z]' '[a-z]'`
 
        # Perform various search/replaces on the filename to clean things up
        newname=$(echo "$newname" | sed 's/----/-/') #remove multiple dashes
        newname=$(echo "$newname" | sed 's/---/-/') #remove multiple dashes
        newname=$(echo "$newname" | sed 's/--/-/') #remove multiple dashes
        newname=$(echo "$newname" | sed 's/-\./\./') #Remove any dashes that appear before the file extension period
        newname=$(echo "$newname" | sed 's/-s-/s-/') #Fix words that end in apostrophe S (there-s- becomes theres-)
        newname=$(echo "$newname" | sed 's/-d-/d-/') #Fix words that end in apostrophe D (they-d- becomes theyd-)
        newname=$(echo "$newname" | sed 's/-re-/re-/') #Fix words that end in apostrophe RE (they-re- becomes theyre-)
        newname=$(echo "$newname" | sed 's/-ve-/ve-/') #Fix words that end in apostrophe VE (they-ve- becomes theyve-)
 
        #Rename file
        echo "Moving $file"
        echo "To $newname"
        echo ""
        mv "$file" "$newname"
 
        #Update all references to the new filenames in all HTML files
        echo `sed -i "s/$file/$newname/g" *.$fileextension`
    fi
done

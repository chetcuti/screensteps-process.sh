screensteps-process.sh
======================

A bash script used to do some post-processing on HTML files exported by ScreenSteps Desktop v2.9.6 Build 3 (though it my work
with other 2.x versions), and make them more SEO-friendly.

**NOTE:** Since this script was created to help with SEO, it only works if you have your lessons output to the same folder as
your table of contents (that is, if the ToC is in / and your lessons are in /lessons/, it won't work).

**USAGE:** Change the "fileextension" variable to the extension that you have ScreenSteps export in. Then just run this script
in the directory with your documentation (you can also move the script somewhere in your PATH, but you still need to execute it
from your documents folder).

This script:
- Changes all filenames from uppercase to lowercase
- Changes instances of multiple dashes to single dashes
- Removes any dashes that appear at the end of the filename (before the extension)
- Converts apostrophe'd words to be more human and SEO friendly (they-re- becomes theyre-)
- Does a search and replace in all files, updating the old filenames to the new filenames

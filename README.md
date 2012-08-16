gdvk-abschproj
==============

Checkout the project:

    git clone git@github.com:ocean90/gdvk-abschproj.git

After that it's required to setup some linebreak-correction filters
which ensure that the actionscript files are commited correctly.

This is required because it isn't possible to checkin some git
configuration parameters and the Adobe Flash Professional use the old
MacOS 9 linebreak instead of standard unix linebreak (which use also OSX).

    cd gdvk-abschproj
    git config --add filter.cr.clean "tr '\r' '\n'"
    git config --add filter.cr.smudge "tr '\n' '\r'"

Optional: Check the filter configuration:

    cat .gitattributes
    git config --list | grep filter


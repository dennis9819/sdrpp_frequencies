#!/bin/bash
SCRIPT=$(readlink -f $0)
SCRIPTPATH=`dirname $SCRIPT`

##### generate jsons
$SCRIPTPATH/genBookmark.sh ../input/freq_lpd.csv LPD ../bookmarks_lpd.json
$SCRIPTPATH/genBookmark.sh ../input/freq_pmr.csv PMR ../bookmarks_pmr.json
$SCRIPTPATH/genBookmark.sh ../input/freq_freenet.csv FN ../bookmarks_freenet.json
$SCRIPTPATH/genBookmark.sh ../input/freq_cb.csv CB ../bookmarks_cb.json

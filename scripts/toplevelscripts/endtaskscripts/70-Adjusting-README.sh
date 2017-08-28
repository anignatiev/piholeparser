#!/bin/bash
## Adjusting Readme.md

## Variables
SCRIPTBASEFILENAME=$(echo `basename $0 | cut -f 1 -d '.'`)
script_dir=$(dirname $0)
SCRIPTVARSDIR="$script_dir"/../../scriptvars/
STATICVARS="$SCRIPTVARSDIR"staticvariables.var
if
[[ -f $STATICVARS ]]
then
source $STATICVARS
else
echo "Static Vars File Missing, Exiting."
exit
fi
if
[[ -f $TEMPVARS ]]
then
source $TEMPVARS
else
echo "Temp Vars File Missing, Exiting."
exit
fi

RECENTRUN="$ENDTASKSCRIPTSLOGDIR""$SCRIPTBASEFILENAME".md

if
[[ -f $MAINREADME ]]
then
rm $MAINREADME
fi

if
[[ ! -f $MAINREADME ]]
then
cp $MAINREADMEDEFAULT $MAINREADME
fi

if
[[ -n $STARTTIME ]]
then
STARTTIMEMD="Script Started At $STARTTIME"
else
STARTTIMEMD="Error Setting Start Time."
fi
if
[[ -f $MAINREADME ]]
then
sed -i "s/LASTRUNSTART/$STARTTIMEMD/" $MAINREADME
fi

if
[[ -n $ENDTIME ]]
then
ENDTIMEMD="Script Ended At $ENDTIME"
else
STARTTIMEMD="Error Setting End Time."
fi
if
[[ -f $MAINREADME ]]
then
sed -i "s/LASTRUNSTOP/$ENDTIMEMD/" $MAINREADME
fi

if
[[ -n $TOTALRUNTIME && -n $HOWMANYSOURCELISTS ]]
then
TOTALRUNTIMEMD="Script Took $TOTALRUNTIME Minutes To Filter $HOWMANYSOURCELISTS Lists."
else
TOTALRUNTIMEMD="Error Calculating Script Run Time."
fi
if
[[ -f $MAINREADME ]]
then
sed -i "s/TOTALELAPSEDTIME/$TOTALRUNTIMEMD/" $MAINREADME
fi

if
[[ -n $AVERAGEPARSETIME ]]
then
AVERAGELISTPARSINGTIMEMD="Average Parsing Time Was $AVERAGEPARSETIME Minutes."
else
AVERAGELISTPARSINGTIMEMD="Error Setting Average Parse Time."
fi
if
[[ -f $MAINREADME ]]
then
sed -i "s/AVERAGELISTPARSINGTIME/$AVERAGELISTPARSINGTIMEMD/" $MAINREADME
fi

if
[[ -n $EDITEDALLPARSEDSIZEMB && -n $EDITEDALLPARSEDHOWMANYLINES ]]
then
EDITEDALLPARSEDMD="The Edited AllParsed File is $EDITEDALLPARSEDSIZEMB MB And Contains $EDITEDALLPARSEDHOWMANYLINES Domains."
else
EDITEDALLPARSEDMD="Error Calculating Size of AllParsed File."
fi
if
[[ -f $MAINREADME ]]
then
sed -i "s/EDITEDALLPARSEDINFO/$EDITEDALLPARSEDMD/" $MAINREADME
fi

if
[[ -n $RECENTRUNLOGSDIRRAWMD ]]
then
THEMAINLOGFILE='[Log Of Recent Run]("$RECENTRUNLOGSDIRRAWMD")'
else
THEMAINLOGFILE="Error Setting Run Log Link"
fi
if
[[ -f $MAINREADME ]]
then
sed -i "s/RECENTRUNMAINLINK/$THEMAINLOGFILE/" $MAINREADME
fi

if
[[ -n $RECENTRUNWITHOUTHTTPSMD ]]
then
LISTSWITHOUTHTTPSLOG='[Lists that do NOT uses https]("$RECENTRUNWITHOUTHTTPSMD")'
else
LISTSWITHOUTHTTPSLOG="Error Setting https-less Link"
fi
if
[[ -f $MAINREADME ]]
then
sed -i "s/LISTSWITHOUTHTTPSLINK/$LISTSWITHOUTHTTPSLOG/" $MAINREADME
fi



#sed "s/RECENTRUNMAINLINK/$THEMAINLOGFILE/; s/LISTSWITHOUTHTTPSLINK/$LISTSWITHOUTHTTPSLOG/; s/NAMEOFTHEREPOSITORY/$REPONAME/; s/AVERAGELISTPARSINGTIME/$AVERAGELISTPARSINGTIMEMD/; s/LASTRUNSTART/$STARTTIMEMD/; s/LASTRUNSTOP/$ENDTIMEMD/; s/TOTALELAPSEDTIME/$TOTALRUNTIMEMD/; s/EDITEDALLPARSEDINFO/$EDITEDALLPARSEDMD/" $MAINREADMEDEFAULT > $MAINREADME

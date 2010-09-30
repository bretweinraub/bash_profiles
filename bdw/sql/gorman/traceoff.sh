#!/bin/ksh
#============================================================================
# File:         traceoff.sh
# Date:         09-MAR-98
# Author:       TGorman
# Description:  UNIX shell script to disable SQL*Trace for the specified
#               Oracle server (shadow) process.
#
#               This script should either be SETUID to UNIX account "oracle"
#               and UNIX group "dba" in order to allow people to execute
#               "svrmgrl", or it should be run only under the UNIX account
#               "oracle"...
#
# Modifications:
#
#============================================================================
#
#----------------------------------------------------------------------------
# ...validate command-line parameters...
#----------------------------------------------------------------------------
if (( $# != 1 ))
then
        echo "Usage: traceoff.sh <Unix-PID>; aborting..."
        exit 1
fi
integer _Spid=${1}
if (( $? != 0 ))
then
        echo "Usage: traceoff.sh <Unix-PID>; aborting..."
        echo "(\"<Unix-PID>\" must be a UNIX process ID)"
        exit 1
fi
#
#----------------------------------------------------------------------------
# ...verify that ORACLE_HOME environment variable is set...
#----------------------------------------------------------------------------
if [[ "${ORACLE_HOME}" = "" ]]
then
        echo "ORACLE_HOME not set; aborting..."
        exit 1
fi
#
#----------------------------------------------------------------------------
# ...verify that ORACLE_SID environment variable is set...
#----------------------------------------------------------------------------
if [[ "${ORACLE_SID}" = "" ]]
then
        echo "ORACLE_SID not set; aborting..."
        exit 1
fi
#
#----------------------------------------------------------------------------
# ...verify that ORACLE_HOME environment variable appears to be set correctly
#----------------------------------------------------------------------------
if [ ! -d ${ORACLE_HOME}/bin ]
then
        echo "Directory \"${ORACLE_HOME}/bin\" not found; aborting..."
        exit 1
fi
#
#----------------------------------------------------------------------------
# ...verify that the "svrmgrl" executable is present and executable...
#----------------------------------------------------------------------------
if [ ! -x $ORACLE_HOME/bin/svrmgrl ]
then
        echo "\"${ORACLE_HOME}/bin/svrmgrl\" not found; aborting..."
        exit 1
fi
#
#----------------------------------------------------------------------------
# ...verify that the UNIX process ID is valid for an Oracle server process
# belonging to the current instance...
#----------------------------------------------------------------------------
_PID=`/bin/ps -eaf | \
        grep oracle${ORACLE_SID} | \
        grep -v grep | \
        awk '{print "~"$2"~"}' | \
        grep "~${_Spid}~"`
if [[ "${_PID}" = "" ]]
then
        echo "Server process ${_Spid} not valid for this instance; aborting..."
        exit 1
fi
#
#----------------------------------------------------------------------------
# ...enable SQL trace for the process...
#----------------------------------------------------------------------------
$ORACLE_HOME/bin/svrmgrl << __EOF__
connect internal
oradebug setospid ${_Spid}
oradebug event 10046 trace name context off
exit
__EOF__
if (( $? != 0 ))
then
        echo "\"svrmgrl\" exited with failure status; aborting..."
        exit 1
else
        echo "SQL*Trace disabled successfully."
        exit 0
fi

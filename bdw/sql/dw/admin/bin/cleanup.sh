#!/bin/ksh
#============================================================================
# File:		cleanup.sh
# Type:		UNIX korn-shell script
# Author:	Tim Gorman (Evergreen Database Technologies, Inc)
# Date:		05jul99
#
# Description:
#
# Exit statuses:
#	0	normal succesful completion
#	1	ORACLE_SID not specified - user error
#	2	ORACLE_SID not valid in ORATAB - user error
#	3*	"admin/bin" directory not found
#	4*	"adump" directory not found
#	5*	"bdump" directory not found
#	6*	"cdump" directory not found
#	7*	"udump" directory not found
#	8*	"alert.log" file not found
#
#       "*" means that a HIGH-severity message is sent to REMEDY
#       "**" means that a CRITICAL-severity message is sent to REMEDY
#
# Modifications:
#============================================================================
_Pgm=cleanup.sh
#
#----------------------------------------------------------------------------
# Verify that the ORACLE_SID has been specified on the UNIX command-line...
#----------------------------------------------------------------------------
if (( $# != 1 ))
then
	exit 1
fi
_OraSid=$1
#
#----------------------------------------------------------------------------
# Verify that the ORACLE_SID is registered in the ORATAB file...
#----------------------------------------------------------------------------
grep ${_OraSid} /var/opt/oracle/oratab > /dev/null 2>&1
if (( $? != 0 ))
then
	exit 2
fi
#
#----------------------------------------------------------------------------
# Set up Oracle environment...
#----------------------------------------------------------------------------
. ~/.profile 2> /dev/null
export PATH=${PATH}:/opt/app/oracle/admin/bin
#
#----------------------------------------------------------------------------
# Set the Oracle environment variables for this database instance...
#----------------------------------------------------------------------------
export ORACLE_SID=${_OraSid}
export ORAENV_ASK=NO
. oraenv
unset ORAENV_ASK
#
#----------------------------------------------------------------------------
# Locate the "admin/bin" directory and the script's log file...
#----------------------------------------------------------------------------
_Bin=/opt/app/oracle/admin/bin
if [ ! -d ${_Bin} ]
then
	notify.sh HIGH ${_OraSid} "${_Pgm}: \"admin/bin\" directory not found"
	exit 3
fi
#
#----------------------------------------------------------------------------
# Locate the "adump" directory...
#----------------------------------------------------------------------------
_ADump=/opt/app/oracle/admin/${ORACLE_SID}/adump
if [ ! -d ${_ADump} ]
then
	notify.sh HIGH ${_OraSid} "${_Pgm}: \"adump\" directory not found"
	exit 4
fi
#
#----------------------------------------------------------------------------
# Locate the "bdump" directory...
#----------------------------------------------------------------------------
_BDump=/opt/app/oracle/admin/${ORACLE_SID}/bdump
if [ ! -d ${_BDump} ]
then
	notify.sh HIGH ${_OraSid} "${_Pgm}: \"bdump\" directory not found"
	exit 5
fi
#
#----------------------------------------------------------------------------
# Locate the "cdump" directory...
#----------------------------------------------------------------------------
_CDump=/opt/app/oracle/admin/${ORACLE_SID}/cdump
if [ ! -d ${_CDump} ]
then
	notify.sh HIGH ${_OraSid} "${_Pgm}: \"cdump\" directory not found"
	exit 6
fi
#
#----------------------------------------------------------------------------
# Locate the "udump" directory...
#----------------------------------------------------------------------------
_UDump=/opt/app/oracle/admin/${ORACLE_SID}/udump
if [ ! -d ${_UDump} ]
then
	notify.sh HIGH ${_OraSid} "${_Pgm}: \"udump\" directory not found"
	exit 7
fi
#
#----------------------------------------------------------------------------
# Locate the "alert.log" file...
#----------------------------------------------------------------------------
_AlertLog=${_BDump}/alert_${ORACLE_SID}.log
if [ ! -r ${_AlertLog} ]
then
	notify.sh HIGH ${_OraSid} "${_Pgm}: \"alert.log\" file not found"
	exit 8
fi
#
#----------------------------------------------------------------------------
# Rename the existing "alert.log" file to another name...
#----------------------------------------------------------------------------
mv ${_AlertLog} ${_AlertLog}.${_TimeStamp}
#
#----------------------------------------------------------------------------
# Create the new "alert.log" file...
#----------------------------------------------------------------------------
echo "`date`: re-initialized by \"${_Pgm}\"" >> ${_AlertLog}
#
#----------------------------------------------------------------------------
# Compress the old "alert.log" file...
#----------------------------------------------------------------------------
compress ${_AlertLog}.${_TimeStamp} 2> /dev/null
#
#----------------------------------------------------------------------------
# Remove any compressed "alert.log" files older than 180 days...
#----------------------------------------------------------------------------
find ${_BDump} -name "${_AlertLog}*.Z" -mtime +180 -exec rm -f {} \;
#
#----------------------------------------------------------------------------
# Compress any ".aud", "core", or ".trc" files which are older than 3 days...
#----------------------------------------------------------------------------
find ${_ADump} -name "*.aud" -mtime +3 -exec compress {} 2> /dev/null \;
find ${_BDump} -name "*.trc" -mtime +3 -exec compress {} 2> /dev/null \;
find ${_CDump} -name "core" -mtime +3 -exec compress {} 2> /dev/null \;
find ${_UDump} -name "*.trc" -mtime +3 -exec compress {} 2> /dev/null \;
#
#----------------------------------------------------------------------------
# Remove any compressed ".aud", "core", or ".trc" files which are older
# than 30 days...
#----------------------------------------------------------------------------
find ${_ADump} -name "*.aud.Z" -mtime +30 -exec rm -f {} \;
find ${_BDump} -name "*.trc.Z" -mtime +30 -exec rm -f {} \;
find ${_CDump} -name "core.Z" -mtime +30 -exec rm -f {} \;
find ${_UDump} -name "*.trc.Z" -mtime +30 -exec rm -f {} \;
#
#----------------------------------------------------------------------------
# complete
#----------------------------------------------------------------------------
exit 0

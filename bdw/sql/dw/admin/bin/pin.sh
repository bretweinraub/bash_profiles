#!/bin/ksh
#============================================================================
# File:		pin.sh
# Type:		UNIX korn-shell script
# Author:	Tim Gorman (Evergreen Database Technologies, Inc)
# Date:		05jul99
#
# Description:
#
#
# Exit statuses:
#	0	normal succesful completion
#	1	ORACLE_SID not specified - user error
#	2	ORACLE_SID not valid in ORATAB - user error
#	3*	"admin/sql" directory not found - install error
#	4*	"gen_pin.sql" script not found - install error
#	5*	SQL*Plus failed creating a spool file
#	6*	SQL*Plus failed during CONNECT INTERNAL
#	7*	SQL*Plus failed while running "gen_pin.sql"
#
#       "*" means that a HIGH-severity message is sent to REMEDY
#       "**" means that a CRITICAL-severity message is sent to REMEDY
#
# Modifications:
#============================================================================
_Pgm=pin.sh
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
# Verify that the database instance specified is "up"...
#----------------------------------------------------------------------------
_Up=`ps -eaf | grep ora_pmon_${_OraSid} | grep -v grep | awk '{print $NF}'`
if [[ "${_Up}" = "" ]]
then
	exit 0
fi
#
#----------------------------------------------------------------------------
# Set up Oracle environment...
#----------------------------------------------------------------------------
. ~/.profile 2> /dev/null
export PATH=${PATH}:/opt/app/oracle/admin/bin
#
#----------------------------------------------------------------------------
# Verify that the "admin/sql" directory exists...
#----------------------------------------------------------------------------
if [ ! -d /opt/app/oracle/admin/sql ]
then
	notify.sh HIGH ${ORACLE_SID} "${_Pgm}: \"admin/sql\" directory not found"
	exit 3
fi
#
#----------------------------------------------------------------------------
# Verify that the "gen_pins.sql" script exists...
#----------------------------------------------------------------------------
if [ ! -r /opt/app/oracle/admin/sql/gen_pin.sql ]
then
	notify.sh HIGH ${ORACLE_SID} "${_Pgm}: \"gen_pin.sql\" script not found"
	exit 4
fi
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
# Connect via SQL*Plus and product the report...
#----------------------------------------------------------------------------
cd /opt/app/oracle/admin/sql
sqlplus -s /nolog << __EOF__ > /dev/null 2>&1
whenever oserror exit 5
whenever sqlerror exit 6
connect internal
whenever sqlerror exit 7
start gen_pin
exit success
__EOF__
#
#----------------------------------------------------------------------------
# If SQL*Plus exited with a failure status, then exit the script also...
#----------------------------------------------------------------------------
_Rtn=$?
if (( ${_Rtn} != 0 ))
then
	case "${_Rtn}" in
		5) notify.sh HIGH ${ORACLE_SID} "${_Pgm}: spool report failed";;
		6) notify.sh HIGH ${ORACLE_SID} "${_Pgm}: connect internal" ;;
		7) notify.sh HIGH ${ORACLE_SID} "${_Pgm}: gen_pin.sql failed" ;;
	esac
fi
#
exit ${_Rtn}

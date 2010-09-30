#!/bin/ksh
#============================================================================
# File:		chk_db_up.sh
# Type:		UNIX korn-shell script
# Author:	Tim Gorman (Evergreen Database Technologies, Inc)
# Date:		30jun99
#
# Description:
#	Check whether the database instance specified is "up" or "down".
#
# Exit statuses:
#	0	- instance is "up" and available
#	1	- database instance not specified - user error
#	2	- database instance not valid - user error or ORATAB error
#	3**	- database instance "down"
#	4**	- database instance "up" but cannot be connected to
#	5**	- database instance "up" but errors occur after connect
#
#	"*" means that a HIGH-severity error message is sent to REMEDY
#	"**" means that a CRITICAL-severity error message is sent to REMEDY
#
# Modifications:
#============================================================================
_Pgm=chk_db_up.sh
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
# Verify that the database instance specified is "up"...
#----------------------------------------------------------------------------
_Up=`ps -eaf | grep ora_pmon_${_OraSid} | grep -v grep | awk '{print $NF}'`
if [[ "${_Up}" = "" ]]
then
	notify.sh CRITICAL ${_OraSid} "${_Pgm}: PMON not running"
	exit 3
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
# Connect via SQL*Plus and run a simple query...
#----------------------------------------------------------------------------
sqlplus -s /nolog << __EOF__ > /dev/null 2>&1
whenever sqlerror exit 4
connect internal
whenever sqlerror exit 5
select dummy from dual;
exit success
__EOF__
_Rtn=$?
case "${_Rtn}" in
	4) notify.sh CRITICAL ${_OraSid} "${_Pgm}: cannot CONNECT INTERNAL" ;;
	5) notify.sh CRITICAL ${_OraSid} "${_Pgm}: cannot query from DUAL" ;;
esac
#
#----------------------------------------------------------------------------
# Return the exit status from SQL*Plus...
#----------------------------------------------------------------------------
exit ${_Rtn}

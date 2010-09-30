#!/bin/ksh
#============================================================================
# File:		notify_remedy.sh
# Type:		UNIX korn-shell script
# Author:	Tim Gorman (Evergreen Database Technologies, Inc)
# Date:		02jul99
#
# Description:
#
# Exit statuses:
#	0	normal succesful completion
#	1	incorrect command-line parameters - user error
#	2	REMEDY database is not available
#	3	SQL*Plus failed to connect to database
#	4	SQL*Plus failed while generating report
#
# Modifications:
#	TGorman	02jul99	written for Affinia
#============================================================================
_Pgm=notify_remedy.sh
#
#----------------------------------------------------------------------------
# If this is not the host which contains REMEDY, then do nothing...
#----------------------------------------------------------------------------
#if [[ "`hostname`" != "barium" ]]  changed to reflect remedy's new home
if [[ "`hostname`" != "sbddenp02" ]]
then
	echo "${_Pgm}: wrong host contacted"
	exit 0
fi
#
#----------------------------------------------------------------------------
# Verify that the fields for "severity", "Oracle SID", and the error message
# have been passed on the command-line...
#----------------------------------------------------------------------------
if (( $# < 3 ))
then
	echo "${_Pgm}: not enough parameters"
	exit 1
fi
#
typeset -u _Severity=$1
_OraSid=$2
shift 2
_ErrMsg=$*
#
#----------------------------------------------------------------------------
# Set up UNIX environment first...
#----------------------------------------------------------------------------
. ~/.profile 2> /dev/null
#
#----------------------------------------------------------------------------
# Set the Oracle environment variables for the REMEDY database instance...
#----------------------------------------------------------------------------
#export ORACLE_SID=PROD1
export ORACLE_SID=SBORA2
export ORAENV_ASK=NO
#. /opt/app/oracle/admin/bin/oraenv
. /usr/local/bin/oraenv
unset ORAENV_ASK
#
#----------------------------------------------------------------------------
# Verify that the REMEDY database instance specified is "up"...
#----------------------------------------------------------------------------
_Up=`ps -eaf | grep ora_pmon_${ORACLE_SID} | grep -v grep | awk '{print $NF}'`
if [[ "${_Up}" = "" ]]
then
	echo "${_Pgm}: PMON for ${ORACLES_SID} not running"
	exit 2
fi
#
#----------------------------------------------------------------------------
# Connect via SQL*Plus and product the report...
#----------------------------------------------------------------------------
sqlplus -s /nolog << __EOF__ > /dev/null 2>&1
whenever sqlerror exit 3
connect internal
column text new_value V_TEXT
whenever sqlerror exit 4
select	decode(count(*), '0', 'dual', 'OutOfLuckPal') text
from	tr.remedy_polling
where	submitter = 'DB_MONITOR'
and	ticket_type = 'System Information'
and	module = 'Ops: Database'
and	organization_type = 'Internal'
and	organization = 'Affinia'
and	severity = initcap('${_Severity}')
and	remedy_message = '${_OraSid}: ${_ErrMsg}'
and	created_dt >= sysdate - (1/48);
whenever sqlerror exit success
select 1 from &&V_TEXT ;
whenever sqlerror exit 5 rollback
insert into tr.remedy_polling
	(remedy_polling_sid,
	 submitter,
	 submitter_type,
	 submitter_subtype,
	 organization_type,
	 organization,
	 ticket_status,
	 ticket_type,
	 ticket_desc,
	 remedy_message,
	 module,
	 severity,
	 created_dt)
values	(tr.remedy_polling_s.nextval,
	 'DB_MONITOR',
	 'Process',
	 'DB Monitor',
	 'Internal',
	 'Affinia',
	 'Submitted',
	 'System Information',
	 '${_OraSid}: ${_ErrMsg}',
	 '${_OraSid}: ${_ErrMsg}',
	 'Ops: Database',
	 initcap('${_Severity}'),
	 sysdate);
exit success commit
__EOF__
#
#----------------------------------------------------------------------------
# If SQL*Plus exited with a failure status, then exit the script also...
#----------------------------------------------------------------------------
_Rtn=$?
if (( ${_Rtn} != 0 ))
then
	echo "${_Pgm}: exiting SQL*Plus with status ${_Rtn}"
	exit ${_Rtn}
fi
#
#----------------------------------------------------------------------------
# Normal successful completion
#----------------------------------------------------------------------------
echo "Successfully notified REMEDY of ${_Severity} message"
exit 0

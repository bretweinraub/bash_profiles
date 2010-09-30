#!/bin/ksh
#============================================================================
# File:		chk_df.sh
# Type:		UNIX korn-shell script
# Author:	Tim Gorman (Evergreen Database Technologies, Inc)
# Date:		02jul99
#
# Description:
#
#	For all UNIX file-systems which can impact the running of the
#	specified Oracle database instance, notify if they are more than
#	more than 90% full.
#
#	The list of UNIX file-systems to be checked comes from the current
#	settings of the following Oracle initialization parameters:
#
#		LOG_ARCHIVE_DEST_1
#		LOG_ARCHIVE_DEST_2
#		LOG_ARCHIVE_DEST_3
#		LOG_ARCHIVE_DEST_4
#		LOG_ARCHIVE_DEST_5
#		AUDIT_FILE_DEST
#		BACKGROUND_DUMP_DEST
#		CORE_DUMP_DEST
#		USER_DUMP_DEST
#		ORACLE_TRACE_FACILITY_PATH
#		ORACLE_TRACE_COLLECTION_PATH
#
#	as well as the following directories:
#
#		/
#		/var/opt/oracle
#		/tmp
#
# Exit statuses:
#	0	normal succesful completion
#	1	ORACLE_SID not specified - user error
#	2	ORACLE_SID not valid in ORATAB - user error
#	3*	SQL*Plus failed to create "spool" file for report
#	4*	SQL*Plus failed to connect to database
#	5*	SQL*Plus failed while generating report
#	6**	Something is running out of space - check report!!
#
#	"*" means that a HIGH-severity message is sent to REMEDY
#	"**" means that a CRITICAL-severity message is sent to REMEDY
#
# Modifications:
#	TGorman	02jul99	written with "90% full" as threshold
#============================================================================
_Pgm=chk_df.sh
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
sqlplus -s /nolog << __EOF__ > /dev/null 2>&1
whenever oserror exit 3
whenever sqlerror exit 4
connect internal
whenever sqlerror exit 5
set echo off feedb off timi off pau off pages 0 lines 500 trimsp on
spool /tmp/chk_df_${ORACLE_SID}.tmp
col name format a30
col value format a100
select	name,
	replace(value, '?', '${ORACLE_HOME}') value
from	v\$parameter
where	(name like '%_dump_dest'
    or	 name like '%_file_dest'
    or	 name like 'oracle_trace_%_path')
union
select	name,
	substr(value, 9, (instr(value, ' ') - 9)) value
from	v\$parameter
where	name = 'log_archive_dest_1'
and	upper(value) like 'LOCATION=%'
and	exists (select 1 from v\$parameter
		where name = 'log_archive_dest_state_1'
		and value = 'enabled')
union
select	name,
	substr(value, 9, (instr(value, ' ') - 9)) value
from	v\$parameter
where	name = 'log_archive_dest_2'
and	upper(value) like 'LOCATION=%'
and	exists (select 1 from v\$parameter
		where name = 'log_archive_dest_state_2'
		and value = 'enabled')
union
select	name,
	substr(value, 9, (instr(value, ' ') - 9)) value
from	v\$parameter
where	name = 'log_archive_dest_3'
and	upper(value) like 'LOCATION=%'
and	exists (select 1 from v\$parameter
		where name = 'log_archive_dest_state_3'
		and value = 'enabled')
union
select	name,
	substr(value, 9, (instr(value, ' ') - 9)) value
from	v\$parameter
where	name = 'log_archive_dest_4'
and	upper(value) like 'LOCATION=%'
and	exists (select 1 from v\$parameter
		where name = 'log_archive_dest_state_4'
		and value = 'enabled')
union
select	name,
	substr(value, 9, (instr(value, ' ') - 9)) value
from	v\$parameter
where	name = 'log_archive_dest_5'
and	upper(value) like 'LOCATION=%'
and	exists (select 1 from v\$parameter
		where name = 'log_archive_dest_state_5'
		and value = 'enabled')
union
select	'UNIX_root' name, '/' value from dual
union
select	'UNIX_tmp' name, '/tmp' value from dual
union
select	'UNIX_var_opt_oracle' name, '/var/opt/oracle' value from dual
/
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
		3) notify.sh HIGH ${ORACLE_SID} "${_Pgm}: spool report failed"
		   ;;
		4) notify.sh HIGH ${ORACLE_SID} "${_Pgm}: connect internal"
		   ;;
		5) notify.sh HIGH ${ORACLE_SID} "${_Pgm}: report failed"
		   ;;
	esac
	exit ${_Rtn}
fi
#
#----------------------------------------------------------------------------
# If the report contains anything, then run the UNIX command "df -k" against
# the entries 
#----------------------------------------------------------------------------
_OutFile=/tmp/chk_df_${_OraSid}_`date '+%y%m%d%H%M'`.txt
while read _Parm _Dir _Comments
do
	#
	_PctFull=`df -k ${_Dir} | tail -1 | awk '{print $5}' | sed 's/%//'`
	if (( ${_PctFull} >= 90 ))
	then
		if [ ! -w ${_OutFile} ]
		then
			echo "`date`: ORACLE_SID = ${ORACLE_SID}" > ${_OutFile}
			echo "" >> ${_OutFile}
		fi
		echo "\"${_Parm}\" = \"${_Dir}\": ${_PctFull}% full" >> ${_OutFile}
	fi
	#
done < /tmp/chk_df_${ORACLE_SID}.tmp
rm -f /tmp/chk_df_${ORACLE_SID}.tmp
#
if [ -r ${_OutFile} ]
then
	notify.sh CRITICAL ${ORACLE_SID} "${_Pgm}: running out of space - see \"${_OutFile}\""
	exit 6
fi
#
#----------------------------------------------------------------------------
# Return the exit status from SQL*Plus...
#----------------------------------------------------------------------------
exit $?

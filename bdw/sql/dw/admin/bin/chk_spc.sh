#!/bin/ksh
#============================================================================
# File:		chk_spc.sh
# Type:		UNIX korn-shell script
# Author:	Tim Gorman (Evergreen Database Technologies, Inc)
# Date:		01jul99
#
# Description:
#
#	Check the specified database to determine whether:
#
#	1. Any PERMANENT tablespaces are more than 90% full
#	2. Any segments are within 10 extents of exceeding MAXEXTENTS
#	3. Any rollback segments have their high-water mark exceeding
#	   90% of the rollback segments maximum possible size
#	4. The sum of rollback segments high-water marks exceed 90% of
#	   available space in their respective tablespace(s)
#	5. Any redo logfile members are INVALID
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
#       "*" means that a HIGH-severity message is sent to REMEDY
#       "**" means that a CRITICAL-severity message is sent to REMEDY
#
# Modifications:
#============================================================================
_Pgm=chk_spc.sh
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
set echo off feedb off timi off pau off pages 60 newpage 0 lines 500 trimsp on
spool /tmp/chk_spc_${ORACLE_SID}.lst
select	t.tablespace_name "Tablespace(s) over 90% Full",
	s.total_space,
	f.free_space,
	(f.free_space / s.total_space) * 100 pct_free
from	dba_tablespaces			 t,
	(select		tablespace_name,
			sum(bytes) / 1048576 total_space
	 from		dba_data_files
	 group by	tablespace_name) s,
	(select		tablespace_name,
			sum(bytes) / 1048576 free_space
	 from		dba_free_space
	 group by	tablespace_name) f
where	t.contents = 'PERMANENT'
and	s.tablespace_name = t.tablespace_name
and	f.tablespace_name = t.tablespace_name
and	(f.free_space / s.total_space) * 100 <= 10
/
col tablespace_name format a15
col type format a10 word_wrap
col name format a40 heading "Name"
select	tablespace_name,
	segment_type type,
	owner || '.' || segment_name ||
	decode(partition_name, '', '', ' (' || partition_name || ')') name,
	extents,
	max_extents
from	dba_segments
where	max_extents - extents <= 10
and	segment_type <> 'CACHE'
/
col name format a50 heading "Rollback Segment Name"
select	s.segment_name name,
	x.hwmsize,
	((s.initial_extent * s.min_extents) +
		(s.next_extent * (s.max_extents - s.min_extents))) est_maxsize
from	dba_rollback_segs	s,
	v\$rollstat		x
where	x.status = 'ONLINE'
and	s.segment_id = x.usn
and	x.hwmsize >= (.9 * ((s.initial_extent * s.min_extents) +
			     (s.next_extent * (s.max_extents - s.min_extents))))
/
col name format a50 heading "Rollback Segment Name"
select	s.tablespace_name name,
	sum(x.hwmsize) sum_hwmsize,
	f.total_space
from	dba_rollback_segs	s,
	v\$rollstat		x,
	(select		tablespace_name,
			sum(bytes) total_space
	 from		dba_data_files
	 group by	tablespace_name) f
where	x.status = 'ONLINE'
and	s.segment_id = x.usn
and	f.tablespace_name = s.tablespace_name
group by
	s.tablespace_name,
	f.total_space
having	sum(x.hwmsize) > (.9 * f.total_space)
/
col name format a50 heading "Rollback Segment Name"
select	n.name,
	s.status
from	v\$rollstat	s,
	v\$rollname	n
where	n.usn = s.usn
and	s.status <> 'ONLINE'
/
col member format a50 heading "Redo log member"
select	group#,
	status,
	member
from	v\$logfile
where	status = 'INVALID'
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
		3) notify.sh HIGH ${ORACLE_SID} "${_Pgm}: spool report failed";;
		4) notify.sh HIGH ${ORACLE_SID} "${_Pgm}: connect internal" ;;
		5) notify.sh HIGH ${ORACLE_SID} "${_Pgm}: report failed" ;;
	esac
	exit ${_Rtn}
fi
#
#----------------------------------------------------------------------------
# If the report contains anything, then notify the authorities!
#----------------------------------------------------------------------------
if [ -s /tmp/chk_spc_${ORACLE_SID}.lst ]
then
	notify.sh CRITICAL ${ORACLE_SID} "${_Pgm}: running out of space - see \"/tmp/chk_spc_${ORACLE_SID}.lst\""
	exit 6
else
	rm -f /tmp/chk_spc_${ORACLE_SID}.lst
fi
#
#----------------------------------------------------------------------------
# Return the exit status from SQL*Plus...
#----------------------------------------------------------------------------
exit 0

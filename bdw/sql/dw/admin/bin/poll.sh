#!/bin/ksh
#
#----------------------------------------------------------------------------
# Set up environment variables;  make sure ".profile" can be used this way!
#----------------------------------------------------------------------------
. ~/.profile > /dev/null 2>&1
#
#----------------------------------------------------------------------------
# CUSTOMIZE!!!
#----------------------------------------------------------------------------
_Dt=`date '+%m-%d-%y-%H%M'`
_Log=/tmp/poll${_Dt}.log
#
#----------------------------------------------------------------------------
# Execute the "poll.sql" script after CONNECT INTERNAL...
#----------------------------------------------------------------------------
sqlplus internal << __EOF__ >> ${_Log} 2> /dev/null
whenever oserror exit 10
whenever sqlerror exit 1
connect internal
whenever sqlerror exit 2
@/opt/app/oracle/admin/sql/poll
exit success
__EOF__
#
#----------------------------------------------------------------------------
# Handle various errors...
#----------------------------------------------------------------------------
case $? in
	0)	;;
	1)	echo "SQL*Plus failed on CONNECT INTERNAL"
		exit 1;;
	2)	echo "SQL*Plus failed in \"poll.sql\""
		exit 2;;
	*)	echo "SQL*Plus failed"
		exit $?
esac
#
exit 0

#!/bin/ksh
if (($# != 1)) then
   exit 1 
fi
_SQLDIR="/opt/app/oracle/admin/sql/"
_FILE="purge_sessions"
_OraSid=$1
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
#---------------------------------------------------------------------------
# Run the purge_sessions procedure
#___________________________________________________________________________
sqlplus -s /nolog <<__EOF__
whenever sqlerror exit 1
connect internal
whenever sqlerror exit 1
whenever oserror exit 2
@${_SQLDIR}${_FILE}
exit success
__EOF__
exit 0

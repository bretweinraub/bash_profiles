#!/bin/ksh
#============================================================================
# File:		chk_lsnr_up.sh
# Type:		UNIX korn-shell script
# Author:	Tim Gorman (Evergreen Database Technologies, Inc)
# Date:		30jun99
#
# Description:
#	Check whether the Net8 "listener" specified is "up" or "down".
#
# Exit statuses:
#	0	- specified listener is "up" and responding
#	1	- insufficient command-line parameters specified - user error
#       2**       - listener process is "down"
#       3**       - listener not responding
#
#       "**" means that a CRITICAL-severity message is sent to REMEDY
#
# Modifications:
#============================================================================
_Pgm=chk_lsnr_up.sh
#
#----------------------------------------------------------------------------
# Verify that the ORACLE_SID has been specified on the UNIX command-line...
#----------------------------------------------------------------------------
if (( $# != 2 ))
then
	exit 1
fi
_Lsnr=$1
_Connect=$2
#
#----------------------------------------------------------------------------
# Set up Oracle environment...
#----------------------------------------------------------------------------
. ~/.profile 2> /dev/null
export PATH=${PATH}:/opt/app/oracle/admin/bin
#
#----------------------------------------------------------------------------
# Verify that the Net8 "listener" process specified is "up" and running...
#----------------------------------------------------------------------------
_Up=`ps -eaf | grep tnslsnr | grep ${_Lsnr} | grep -v grep | awk '{print $2}'`
if [[ "${_Up}" = "" ]]
then
	notify.sh CRITICAL ${_Connect} "${_Pgm}: no listener process"
	exit 2
fi
#
#----------------------------------------------------------------------------
# Verify that the Net8 "listener" process specified is responding...
#----------------------------------------------------------------------------
tnsping ${_Connect} > /dev/null 2>&1
if (( $? != 0 ))
then
	notify.sh CRITICAL ${_Connect} "${_Pgm}: tnsping failed"
	exit 3
fi
#
#----------------------------------------------------------------------------
# Normal completion...
#----------------------------------------------------------------------------
exit 0

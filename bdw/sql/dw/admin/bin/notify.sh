#!/bin/ksh
#============================================================================
# File:		notify.sh
# Type:		UNIX korn-shell script
# Author:	Tim Gorman (Evergreen Database Technologies, Inc)
# Date:		02jul99
#
# Description:
#	Shell script to insert an error notification message into REMEDY.
#
#	If the message cannot be inserted, then store it in a file locally
#	for later resend...
#
# Exit statuses:
#	0	REMEDY notified successfully
#	1	error occurred - REMEDY not notified
#
# Modifications:
#	TGorman	02jul99	written for Affinia
#============================================================================
#
#----------------------------------------------------------------------------
# Set some shell variables to hold:
#	- directory name where unsent messages are to be stored
#	- hostname for machine where REMEDY resides
#	- temporary filename for scratch
#----------------------------------------------------------------------------
_MsgDir=/opt/app/oracle/admin/msgs
#_Host=10.1.1.41  --Changed this to point to Remedy's new home jtd 08/06/99
_Host=dnsdent01
_TmpFile=/tmp/notify_$$.err
#
#----------------------------------------------------------------------------
# Try to send the message to REMEDY...
#----------------------------------------------------------------------------
rsh -n ${_Host} "/opt/app/oracle/admin/bin/notify_remedy.sh $*" > ${_TmpFile}
#
#----------------------------------------------------------------------------
# Examine the output from the "notify_remedy.sh" script;  if it contains
# the required phrase, then we were successful...
#
# If we were not successful, then save the message in a file in the directory
# of unsent messages, for later forwarding...
#----------------------------------------------------------------------------
grep -i "^successfully notified" ${_TmpFile} > /dev/null 2>&1
if (( $? != 0 ))
then
	#
	#--------------------------------------------------------------------
	# Save the command-line parameters for the "notify_remedy.sh" script
	#--------------------------------------------------------------------
	echo "$*" >> ${_MsgDir}/notify_remedy_$$.txt
	exit 1
fi
exit 0
#
#----------------------------------------------------------------------------
# Since we were successful sending this message, let's check to see if there
# are any unsent messages to be forwarded.
#
# First, check to see if anyone else is already doing this.  If so, then
# back off and exit.  Otherwise, "lock" the directory of unsent messages...
#----------------------------------------------------------------------------
if [ -r ${_MsgDir}/lock ]
then
	exit 0
fi
touch ${_MsgDir}/lock
#
#----------------------------------------------------------------------------
# One by one, retrieve the unsent messages and attempt to resend them...
#----------------------------------------------------------------------------
for _f in `ls -1rt ${_MsgDir}/notify_remedy_*.txt`
do
	#
	#--------------------------------------------------------------------
	# Sending...
	#--------------------------------------------------------------------
	_Msgs=`cat ${_f}`
	rsh -n ${_Host} "/opt/app/oracle/admin/bin/notify_remedy.sh ${_Msgs}" > ${_TmpFile}
	#
	#--------------------------------------------------------------------
	# If successful, then delete the file containing the message just
	# successfully sent...
	# Otherwise, just leave the file where it is, and someone'll try
	# again later...
	#--------------------------------------------------------------------
	grep -i "^successfully notified" ${_TmpFile} > /dev/null 2>&1
	if (( $? == 0 ))
	then
		rm -f ${_f}
	fi
done
#
#----------------------------------------------------------------------------
# Cleanup...
#----------------------------------------------------------------------------
rm -f ${_MsgDir}/lock ${_TmpFile}
#
#----------------------------------------------------------------------------
# Normal, successful completion
#----------------------------------------------------------------------------
exit 0

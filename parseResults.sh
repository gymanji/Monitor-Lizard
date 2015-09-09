#!/bin/bash

PATTERN=(500 501 401 503)
LOG_FILE="/Users/Zach/Development/GitHub Repos/Monitor-Lizard/svc.csv"
VAR_FILE="/Users/Zach/Development/GitHub Repos/Monitor-Lizard/vars.txt"
MAX_ERRORS=3
ERROR_COUNTER=$(cat $VAR_FILE)

export logError

for i in ${PATTERN[@]}
do
	if tail -n 5 $LOG_FILE | grep -q $i
		# Can probably add regex via grep,sed, or awk as piped expression to end of tailed filter above to
		# also retain the specific server as "$chatty" (or the likes) that encountered the error
	   then
		   logError=$(echo "$i found in service log")
		   echo $logError
		   ERROR_COUNTER=$(($ERROR_COUNTER + 1))
		   INTERATOR=$(cat $VAR_FILE)

		   if (($INTERATOR > $MAX_ERRORS))
		   		then
		   			echo 'error_counter went over...'
					./logTimeStamp2.sh
		   			printf "Just exceeded MAX_ERROR limit" >> $LOG_FILE 2>&1
		   			printf "\n" >> $LOG_FILE 2>&1

		   			# Clear current crontab to remove chance for multiple manipulation points
	   				crontab -r
	   				
		   			# SSH to respective server to fix error
		   				# ssh $chatty
		   				# sudo service stop
		   				# sudo service start 
		   				## More robust verification that service successfully re-starts before exiting would be benefiical
		   				# quit

		   			
		   			# Need to add logic to re-check endpoint and exit if complete, or retry multiple times until fixed
			   			# Obtain fresh data after service re-starts
						# ./is-it-working.sh

						# OK to go recursive with re-parsing svc log in line below?
	   					# ./parseResults.sh

	   				# Reload crontab for scheduled jobs once verification complete
	   				crontab monitor-crontab.txt

   					# Notify Ops of changes made
		   				# ./sendEmail.sh

		   			./logTimeStamp2.sh
		   			printf "Emailed SaaSOps about MAX_ERROR limit exception" >> $LOG_FILE 2>&1
		   			printf "\n" >> $LOG_FILE 2>&1

		   			# re-initialize VAR_FILE back to default (0)
		   			printf 0 > $VAR_FILE
		   			
		   			exit 1
			   	else 
			   		echo $ERROR_COUNTER > $VAR_FILE
	   		fi
		   
	   else
            echo $i not found
	fi
done


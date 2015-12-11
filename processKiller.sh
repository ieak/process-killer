#!/bin/bash
###############################################################################
### Header ###
# This script searches, finds and kills the processes running longer than expected 
# For example kill selenium process if it continues more than 30 minutes!
# author    "iffet Oguz & Ahmet Kurukose"
# date      24.03.2014
# contact   iffetoguz@gmail.com & ahmet.kurukose@gmail.com

###############################################################################
### Definitions of Process Name & Termination Time Interval ###

#Searching Keyword definition to seperate the process from other running elements
PROCESS_TO_KILL=selenium

#Definition of Elapsed Time in terms of minutes to kill the corresponding
#processes after they started to run
KILLTIME=25

###############################################################################
### Logging Function Definition ###

LOG_FILE=/tmp/KILLER.LOG

function log {
    echo "$(date +"%Y.%m.%d %H:%M:%S") - $1" >> $LOG_FILE
}

###################################IEAK#########################################
### Process Killing Action ###
log "---Start of Process Killing Action---"

ps -eo etime,pid,cmd |grep "$PROCESS_TO_KILL" | grep -v grep |  while read line; do 

    ELAPSED_TIME=$(echo $line | awk '{printf $1}')
    PID=$(echo $line | awk '{printf $2}')
        
    if [ "x${#ELAPSED_TIME}" == "x5" ];then
        MINUTES=$(echo $ELAPSED_TIME| cut -d ":" -f 1 )
        log "$PROCESS_TO_KILL is running for $ELAPSED_TIME"
        
        if (( $MINUTES > $KILLTIME  )); then
            log "Process is killed: $line"
            kill -9 $PID    
        fi

    elif [ "x${#ELAPSED_TIME}" == "x8" ]; then 
        HOURS=$(echo $ELAPSED_TIME| cut -d ":" -f 1 )
        MINUTES=$(echo $ELAPSED_TIME| cut -d ":" -f 2 )
        TOTAL_ELAPSED_TIME=$(( ((HOURS * 60)) + MINUTES  ))
        log "$PROCESS_TO_KILL is running for $ELAPSED_TIME"
        
        if (( $TOTAL_ELAPSED_TIME > $KILLTIME  )); then
            log "Process is killed: $line"
            kill -9 $PID
        fi
    
    else
        DAYS=$(echo $ELAPSED_TIME| cut -d "-" -f 1)
        HOURS=$(echo $ELAPSED_TIME| cut -d "-" -f 2|cut -d ":" -f 1 )
        MINUTES=$(echo $ELAPSED_TIME| cut -d "-" -f 2|cut -d ":" -f 2 )
        TOTAL_ELAPSED_TIME=$(( (( DAYS * 24 * 60  )) + ((HOURS * 60)) + MINUTES  ))
        log "$PROCESS_TO_KILL is running for $ELAPSED_TIME"
        
        if (( $TOTAL_ELAPSED_TIME > $KILLTIME  )); then
            log "Process is killed: $line"
            kill -9 $PID
        fi
    fi;
done

log "---End of Process Killing Action---"

###############################################################################

# process-killer
This Linux Bash Script is scheduled on crontab and then searches, finds and kills the processes running longer than expected. For example kill selenium process if it continues more than 30 minutes!

The script will make easier life for systems administrators. If you have so many scheduled tasks on your crontab and sometimes one of the process get stuck and prevent other processes from running, you can use this script to kill stuck process.

# How to Use

1 - Download the process-killer file.
   
2 - Extract it and locate on your Linux PC. (For example: /root/ieak/scripts/processKiller.sh)
  
3 - Enter your troubled process name next to "PROCESS_TO_KILL" field. (For example: PROCESS_TO_KILL=selenium)
  
4 - Enter maximum running time interval next to "KILLTIME" field. (For example: KILLTIME=30)
  
5 - If you do not change log file will be generated on "/tmp/KILLER.LOG".
  
6 - Save your settings.
  
7 - Schedule the script on crontab. Example case as followings:
  
    crontab -e

    */5 0,9 * * * /root/ieak/scripts/processKiller.sh

(This crontab line refer that this script will be run in every 5 minutes at every night between 00.00 and 09.00)


# Running Progress / Expected Results

According to example cases: Script will run in every 5 minutes to find selenium process running more than 30 minutes.

    When found, it will kill the selenium process.

    When not found, it will wait 5 minutes and run again.

    Results may be checked from the log file: "/tmp/KILLER.LOG"

# Authors and Contributors

In 2014, iffet and Ahmet Kuruköse (@ieak) developed Kill Process script.

# Support or Contact

Having trouble with Pages? Check out our documentation [https://github.com/ieak/process-killer/blob/master/README.md] or contact support [https://github.com/contact] and we’ll help you sort it out.

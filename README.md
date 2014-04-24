smartstart
==========

Start up programs at Boot based on Day of Week or IP Address.

smartstart is a command line program. Instead of running all your programs during bootup configure them in smartstart and then set smartstart to run. It will then run those programs which meet the criteria you specify.

For example, to run Outlook on weekdays only run the following command:

  smartstart -a "C:\Program Files\Microsoft Office\Office14\OUTLOOK.EXE" day "mon,tue,wed,thu,fri"

and then schedule smartstart to run at boot up with smartstart -r

Run smartstart --help for further information


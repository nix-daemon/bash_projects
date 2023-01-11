#! /bin/bash
echo Hostname:
uname -a
echo
echo ----------
echo Check passwd below for new accounts sorted by UID. Look for anything suspicious, especially with a UID less than 500:
echo
sudo sort -nk3 -t: /etc/passwd
echo ----------
echo Check for unexpected UID 0 accounts:
echo
sudo egrep ':0+:' /etc/passwd
echo ----------
echo In this section are any orphaned files left over by a deleted user which could have been created by an intruder:
echo
echo ----------
echo Check below for an abnormal amount of memory usage:
echo
free
echo ----------
echo Check below for abnormal decreases in available disk space:
echo
df
echo ----------
echo Check below for any anomalous proccesses. Use lsof -p [pid] for additional invesigation on a process:
echo
ps -aux
echo ----------
echo Check below for anomalous services that may be enabled at various run levels. Will not work if chkconfig is not installed:
echo
chkconfig --list
echo ----------
echo Check below for any anomalous SUID root files:
sudo find / -uid 0 -perm -4000 2>/dev/null
echo ----------
echo Check below for any unusual large files:
echo
sudo find / -size +10000k 2>/dev/null
echo ----------
echo Check below for any files with dots and spaces used to camouflage:
echo
sudo find / -name " " 2>/dev/null
sudo find / -name ".. " 2>/dev/null
sudo find / -name ". "  2>/dev/null
echo ----------
echo Check below for processes running out of or accessing files that have been unlinked. May sugggest hidden data or a backdoor:
echo
sudo lsof +L1
echo ----------
echo Check below for any interfaces that are in promisc mode, but should not be:
echo
ip link | grep PROMISC
echo ----------
echo Check below for any unusual port listeners:
echo 
sudo netstat -nap
echo ----------
echo Check below for details on running processes listening on ports:
echo
sudo lsof -i
echo ----------
echo Check below for any unusual arp entries:
echo
arp -a
echo ----------
echo Check below for anomalous cron jobs scheduled by root or any other UID 0 accounts:
echo
sudo crontab -u root -l
echo ----------
echo Check below for unsual system-wide cron jobs:
echo
sudo cat /etc/crontab
sudo ls /etc/cron.*
echo ----------
echo Below are all .bashrc files on this system. Investigate their contents for any scripts or programs set to autostart:
echo
sudo find / -name ".bashrc" 2>/dev/null
echo ----------
echo Below are all shell scripts on the system. Investigate the contents for any anomalous or unapproved scripts:
echo
sudo find / -name "*.sh" 2>/dev/null
echo ----------
echo Below are a list of other persistence locations that are autostarted on this system. Investigate their contents for anomalous activities:
echo
sudo find / -name ".bash_profile" 2>/dev/null
sudo find / -name ".bash_login" 2>/dev/null
sudo find / -name ".profile" 2>/dev/null
sudo find / -name ".bash_logout" 2>/dev/null
echo ----------
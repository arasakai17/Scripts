#!/bin/bash

#Argument Supplied Check
display_usage() { 
	echo -e "\nUsage: $0 <IP Address>\n" 
	} 
# if less than 3 arguments supplied, display usage 
if [  $# -le 0 ] 
then 
	display_usage
	exit 1
fi 
 
# check whether user had supplied -h or --help . If yes display usage 
if [[ ( $@ == "--help") ||  $@ == "-h" ]] 
then 
	display_usage
	exit 0
fi 

# Variable Assignment
ip=$1
scriptDir=$(pwd)

mkdir $ip && cd $ip
mkdir nmapScans && cd nmapScans

echo -e "===== Folders Created =====\n"
pwd
echo -e "\n===== Begining Nmap Port Scan =====\n"

#nmap scan to identify all open port
sudo nmap -sUT -p- -Pn --min-rate 20000 --script vulners.nse $ip --open -o nmapPortScan.txt

#formating port numbers so we can perform service scans
cat nmapPortScan.txt | grep "/tcp\|/udp" | cut -d "/" -f 1 > ports.txt
awk '{print $1}' ports.txt | paste -s -d, - > portList.txt

#scan for services on the open portss
echo -e "\n===== Begining Nmap Service Scan =====\n"
sudo nmap -sUT -p $(cat portList.txt) -sVC -Pn $ip --open -o sVC_Port_Scan.txt

#open ports for report 
cat sVC_Port_Scan.txt | grep "PORT\|open" > ports_for_report.txt

#Begin Feroxbuster Scan | this will run in background, output can be read from the output file
cd $scriptDir
echo $scriptDir
./web_enum.sh $ip 




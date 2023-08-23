#snmp automatic recon

ip=$1

#set up files for onesixtyone
echo public > community
echo private >> community
echo manager >> community
echo $ip > ip_list

echo "========= Running onsixtyone ========="
onesixtyone -c community -i ip_list -o onsixtyone.out


echo "========= Running snmpwalk scripts (8 scans) ========="
echo "  snmpwalk_System_Processes "
snmpwalk -c public -v1 -t 10 $ip 1.3.6.1.2.1.25.1.6.0 > snmpwalk_System_Processes.out
echo "  DONE 1/8 "

echo "  snmpwalk_Running_Programs "
snmpwalk -c public -v1 -t 10 $ip 1.3.6.1.2.1.25.4.2.1.2 > snmpwalk_Running_Programs.out
echo "  DONE 2/8"

echo "  snmpwalk_Processes_Path "
snmpwalk -c public -v1 -t 10 $ip 1.3.6.1.2.1.25.4.2.1.4 > snmpwalk_Processes_Path.out
echo "  DONE 3/8"

echo "  snmpwalk_Storage_Units "
snmpwalk -c public -v1 -t 10 $ip 1.3.6.1.2.1.25.2.3.1.4 > snmpwalk_Storage_Units.out
echo "  DONE 4/8 "

echo "  snmpwalk_Software_Name "
snmpwalk -c public -v1 -t 10 $ip 1.3.6.1.2.1.25.6.3.1.2 > snmpwalk_Software_Name.out
echo "  DONE 5/8"

echo "  snmpwalk_User_Accounts "
snmpwalk -c public -v1 -t 10 $ip 1.3.6.1.4.1.77.1.2.25 > snmpwalk_User_Accounts.out
echo "  DONE 6/8 "

echo "  snmpwalk_TCP_Local_Ports "
snmpwalk -c public -v1 -t 10 $ip 1.3.6.1.2.1.6.13.1.3 > snmpwalk_TCP_Local_Ports.out
echo "  DONE 7/8"

echo "  snmpwalk_General "
snmpwalk -c public -v1 -t 10 $ip > snmpwalk_General.out
echo "  DONE 8/8"

echo "========= snmpwalk scripts COMPLETE ========="
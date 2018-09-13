#!/bin/bash
if [ "$1" = "" ] || [ "$2" = "" ] || [ "$3" = "" ]; then echo "you need to put some in here for example: 18 07 18 =(18/7/2018)";exit;fi
if [ $1 == '--help' ] || [ $1 == '-h' ]; then echo "Pelase specify date example: 18 07 18 =(18/7/2018)"; exit; fi
toField="to: grizly1326@gmail.com"
subjectField="subject: Loghost Daily Update for "$(date +%D)""
nameOfFile="/home/grizly1326/find.txt"
IFS=$'\n'
$(rm $nameOfFile)

#echo $toField>>$nameOfFile
#echo $subjectField>>$nameOfFile
echo "uptade for the: "$1"/"$2"/20"$3>>$nameOfFile
echo "">>$nameOfFile
varArr=($(sudo cat /NetworkLogs/gateway.home/20$(date +%y)/$(date +%m)/system-gateway.home.log | grep -e " $1 "))
echo "Number of All logs to gateway:"${#varArr[@]}>>$nameOfFile
varArr=($(sudo cat /NetworkLogs/main-server/20$(date +%y)/$(date +%m)/system-main-server.log | grep -e " $1 "))
echo "Number of All logs to main-server:"${#varArr[@]}>>$nameOfFile

echo "########################### Gateway config changes ###########################">>$nameOfFile
varArr=($(sudo cat /NetworkLogs/gateway.home/20$3/$2/system-gateway.home.log | grep system\,info\  | grep -e " $1 "))
echo "Number of Connections:"${#varArr[@]}>>$nameOfFile
echo "--LOGS--">>$nameOfFile
for j in ${!varArr[@]}
do
        echo ${varArr[$j]}>>$nameOfFile
done
echo "########################### Gateway sucesfull PPTP connections ###########################">>$nameOfFile
varArr=($(sudo cat /NetworkLogs/gateway.home/20$3/$2/system-gateway.home.log | grep pptp,ppp,info.account | grep logged\ in | grep -e " $1 "))
echo "Number of Connections:"${#varArr[@]}>>$nameOfFile
echo "--LOGS--">>$nameOfFile
for j in ${!varArr[@]}
do
	echo ${varArr[$j]}>>$nameOfFile
done
echo "########################### Gateway Un-sucesfull PPTP connections ###########################">>$nameOfFile
varArr=($(sudo cat /NetworkLogs/gateway.home/20$3/$2/system-gateway.home.log | grep pptp,ppp,error | grep -e " $1 "))
echo "Number of Connections:"${#varArr[@]}>>$nameOfFile
echo "--LOGS--">>$nameOfFile
for j in ${!varArr[@]}
do
        echo ${varArr[$j]}>>$nameOfFile
done
echo "########################### Gateway sucesfull connections ###########################">>$nameOfFile
varArr=($(sudo cat /NetworkLogs/gateway.home/20$3/$2/system-gateway.home.log | grep system,info,account | grep -e " $1 "))
echo "Number of Connections:"${#varArr[@]}>>$nameOfFile
echo "--LOGS--">>$nameOfFile
for j in ${!varArr[@]}
do
        echo ${varArr[$j]}>>$nameOfFile
done
echo "########################### Gateway Un-sucesfull connections ###########################">>$nameOfFile
varArr=($(sudo cat /NetworkLogs/gateway.home/20$3/$2/system-gateway.home.log | grep system,error | grep login\ failure | grep -e " $1 "))
echo "Number of Connections:"${#varArr[@]}>>$nameOfFile
echo "--LOGS--">>$nameOfFile
for j in ${!varArr[@]}
do
        echo ${varArr[$j]}>>$nameOfFile
done
echo "########################### Main-Server sucesfull connections ###########################">>$nameOfFile
varArr=($(sudo cat /NetworkLogs/main-server/20$3/$2/system-main-server.log | grep Accepted\ publickey | grep -e " $1 "))
echo "Number of Connections:"${#varArr[@]}>>$nameOfFile
echo "--LOGS--">>$nameOfFile
for j in ${!varArr[@]}
do
        echo ${varArr[$j]}>>$nameOfFile
done
echo "########################### Main-Server Un-sucesfull connections ###########################">>$nameOfFile
varArr=($(sudo cat /NetworkLogs/main-server/20$3/$2/system-main-server.log | grep Invalid\ user | grep -e " $1 "))
echo "Number of Connections:"${#varArr[@]}>>$nameOfFile
echo "--LOGS--">>$nameOfFile
for j in ${!varArr[@]}
do
        echo ${varArr[$j]}>>$nameOfFile
done
echo "########################### DHCP autentication  ###########################">>$nameOfFile
echo "">>$nameOfFile
sudo cat /NetworkLogs/gateway.home/20$3/$2/system-gateway.home.log | grep assigned | grep to | awk '{print $6 "\t" $8 "\t " $10 }' | sort | uniq -c | sort -n | awk 'BEGIN {print "--------\t--------\t--------\t--------"} {print}'| awk 'BEGIN {print "#Ocurences\tNetwork\tIPAddress\tMACAddress"} {print}' | column -t >>$nameOfFile


echo "Your report has been finished, please open -----> "$nameOfFile" <----- to view your report."

#!/bin/bash
lenBuf=2
toField="to: grizly1326@gmail.com"
fromField="from: loghost";
subjectField="subject: Loghost Daily Update for "$(date +%D)""
nameOfFile="/home/grizly1326/send.txt"
IFS=$'\n'
$(rm $nameOfFile)

echo $toField>>$nameOfFile
echo $subjectField>>$nameOfFile
echo $fromField>>$nameOfFile
echo "Content-Type: text/html">>$nameOfFile
echo "<html><body>">>$nameOfFile
varArr=($(sudo cat /NetworkLogs/gateway.home/20$(date +%y)/$(date +%m)/system-gateway.home.log | grep -e " $(date +%_d) "))
echo "<span style=\"color:blue\">Number of All logs to gateway:"${#varArr[@]}"<br/>">>$nameOfFile
varArr=($(sudo cat /NetworkLogs/main-server/20$(date +%y)/$(date +%m)/system-main-server.log | grep -e " $(date +%_d) "))
echo "<span style=\"color:blue\">Number of All logs to main-server:"${#varArr[@]}"<br/>">>$nameOfFile

echo "<strong>########################### Gateway config changes ###########################</strong><br/>">>$nameOfFile
varArr=($(sudo cat /NetworkLogs/gateway.home/20$(date +%y)/$(date +%m)/system-gateway.home.log | grep system\,info\ | grep -e " $(date +%_d) " | awk '{print $3" "$6" "$NF}'| awk 'BEGIN {print "--------\t--------\t--------"} {print}' | awk 'BEGIN {print "Time\tConfigModified\tUser"}{print}' | column -t))
echo "<span style=\"color:green\">Number of Connections:"$((${#varArr[@]}-$lenBuf))"<br/>">>$nameOfFile
echo "--LOGS--<br/><pre>">>$nameOfFile
for j in ${!varArr[@]}
do
        echo ${varArr[$j]}>>$nameOfFile
done
echo "</pre></span>">>$nameOfFile
echo "<strong>########################### Gateway sucesfull PPTP connections ###########################</strong><br/>">>$nameOfFile
varArr=($(sudo cat /NetworkLogs/gateway.home/20$(date +%y)/$(date +%m)/system-gateway.home.log | grep pptp,ppp,info.account | grep logged\ in | grep -e " $(date +%_d) " | awk '{print $3" "$10" "$6" "$9}' | awk 'BEGIN {print "--------\t--------\t--------"} {print}' | awk 'BEGIN {print "Time\tUser\tIPAddress"}{print}' | column -t))
echo "<span style=\"color:green\">Number of Connections:"$((${#varArr[@]}-$lenBuf))"<br/>">>$nameOfFile
echo "--LOGS--<br/><pre>">>$nameOfFile
for j in ${!varArr[@]}
do
	echo ${varArr[$j]}>>$nameOfFile
done
echo "</pre></span>">>$nameOfFile
echo "<strong>########################### Gateway Un-sucesfull PPTP connections ###########################</strong><br/>">>$nameOfFile
varArr=($(sudo cat /NetworkLogs/gateway.home/20$(date +%y)/$(date +%m)/system-gateway.home.log | grep pptp,ppp,error | grep -e " $(date +%_d) " | awk '{print $3" "$8 " "$9}'| awk 'BEGIN {print "--------\t--------\t--------"} {print}' | awk 'BEGIN {print "Time\tUser\tReasson"}{print}' | column -t))
echo "<span style=\"color:red\">Number of Connections:"$((${#varArr[@]}-$lenBuf))"<br/>">>$nameOfFile
echo "--LOGS--<br/><pre>">>$nameOfFile
for j in ${!varArr[@]}
do
        echo ${varArr[$j]}>>$nameOfFile
done
echo "</pre></span>">>$nameOfFile
echo "<strong>########################### Gateway sucesfull connections ###########################</strong><br/>">>$nameOfFile
varArr=($(sudo cat /NetworkLogs/gateway.home/20$(date +%y)/$(date +%m)/system-gateway.home.log | grep system,info,account | grep logged\ in | grep -e " $(date +%_d) " | awk '{print $3" "$7" "$11}' | awk 'BEGIN {print "--------\t--------\t--------"} {print}' | awk 'BEGIN {print "Time\tUser\tIPAddress"}{print}' | column -t))
echo "<span style=\"color:green\">Number of Connections:"$((${#varArr[@]}-$lenBuf))"<br/>">>$nameOfFile
echo "--LOGS--<br/><pre>">>$nameOfFile
for j in ${!varArr[@]}
do
        echo ${varArr[$j]}>>$nameOfFile
done
echo "</pre></span>">>$nameOfFile
echo "<strong>########################### Gateway Un-sucesfull connections ###########################</strong><br/>">>$nameOfFile
varArr=($(sudo cat /NetworkLogs/gateway.home/20$(date +%y)/$(date +%m)/system-gateway.home.log | grep system,error | grep login\ failure | grep -e " $(date +%_d) " | awk '{print $3" "$10" "$12" "$14}' | awk 'BEGIN {print "--------\t--------\t--------\t--------"} {print}' | awk 'BEGIN {print "Time\tUser\tIPAddress\tEnviroment"}{print}' | column -t))
echo "<span style=\"color:red\">Number of Connections:"$((${#varArr[@]}-$lenBuf))"<br/>">>$nameOfFile
echo "--LOGS--<br/><pre>">>$nameOfFile
for j in ${!varArr[@]}
do
        echo ${varArr[$j]}>>$nameOfFile
done
echo "</pre></span>">>$nameOfFile
echo "<strong>########################### Main-Server sucesfull connections ###########################</strong><br/>">>$nameOfFile
varArr=($(sudo cat /NetworkLogs/main-server/20$(date +%y)/$(date +%m)/system-main-server.log | grep Accepted\ publickey | grep -e " $(date +%_d) " | sort |  sort -n | column -t | awk '{print $3" "$11" "$13 " "$16}' | column -t | awk 'BEGIN {print "--------\t--------\t--------\t--------"} {print}' | awk 'BEGIN {print "Time\tIPAddress\tPort\tSshKey"} {print}' | column -t))
echo "<span style=\"color:green\">Number of Connections:"$((${#varArr[@]}-$lenBuf))"<br/>">>$nameOfFile
echo "--LOGS--<br/><pre>">>$nameOfFile
for j in ${!varArr[@]}
do
        echo ${varArr[$j]}>>$nameOfFile
done
echo "</pre></span>">>$nameOfFile
echo "<strong>########################### Main-Server Un-sucesfull connections ###########################</strong><br/>">>$nameOfFile
varArr=($(sudo cat /NetworkLogs/main-server/20$(date +%y)/$(date +%m)/system-main-server.log | grep Invalid\ user | grep -e " $(date +%_d) " | sort |  sort -n | column -t | awk '{print $3" "$8" "$10}' | column -t | awk 'BEGIN {print "--------\t--------\t--------"} {print}'| awk 'BEGIN {print "Time\tUser\tIPAddress"} {print}' | column -t))
echo "<span style=\"color:red\">Number of Connections:"$((${#varArr[@]}-$lenBuf))"<br/>">>$nameOfFile
echo "--LOGS--<br/><pre>">>$nameOfFile
for j in ${!varArr[@]}
do
        echo ${varArr[$j]}>>$nameOfFile
done
echo "</pre></span><strong>########################### DHCP autentication  ###########################</strong><br/>">>$nameOfFile
echo "<pre><span style=\"color:orange\">">>$nameOfFile
sudo cat /NetworkLogs/gateway.home/20$(date +%y)/$(date +%m)/system-gateway.home.log | grep assigned | grep to | awk '{print $6 "\t" $8 "\t" $10 }' | sort | uniq -c | sort -n | awk 'BEGIN {print "--------\t--------\t--------\t--------"} {print}'| awk 'BEGIN {print "#Ocurences\tNetwork\tIPAddress\tMACAddress"} {print}' | column -t >>$nameOfFile
echo "</pre></span>">>$nameOfFile
echo "</body></html>">>$nameOfFile

$(/usr/sbin/sendmail -vt < $nameOfFile)

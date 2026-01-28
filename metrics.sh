#!/bin/bash
function display_metrics {
echo "     ---- System Metrics ----"
Mem=$( free | grep Mem | awk '{printf ("%.2f",$3/$2*100)}' )
disk_space=$(df -h | head -2 | tail -1 | awk '{print $5}')
cpu_usage=$(top -bn 1 | grep '%Cpu' | awk '{print $2}')
echo "CPU Usage:  $cpu_usage%   Mem Usage:  $Mem%   Disk Space:  $disk_space"
}
function monitor_service {
echo " ---- Monitor a Specific Service ----"
read -p "Enter the name of the service to monitor:" service
if pgrep -x "$service" &>/dev/null;then
echo "$service is running."
else
echo "$service is not running."
read -p "Do you want to start $service? (Y/N):" answer
if [ "$answer" = "Y" ] || [ "$answer" = "y" ];then 
sudo service "$service" start
echo "$service is up."
fi
fi
}
while true;do
echo "---- Monitoring Metrics Script ----"
echo "1. View System Metrics"
echo "2. Monitor a Specific Service"
echo "3. Exit"
read -p "please choose an option (1, 2, or 3):" option
case "$option" in
1)
display_metrics;;
2)
monitor_service;;
3)
echo "Exit from script."
exit 0;;
*)
echo "Error: Invalid option. Please choose a valid option (1, 2, or 3).";
esac
done

#!/bin/bash
function process_check {
if pgrep -x "$1" &>/dev/null ;then
echo "process '$1' is ranning."
return 0 
else 
echo "process '$1' not running."
return 1
fi
}
function restart_process {
sudo systemctl restart "$1"
echo "the process '$1' restarted."
}
function process_monitor {

if process_check "$1" ; then
echo "the process '$1' is always running"
else
att=1
while [ "$att" -le 3 ] ;do 
echo "Process '$1' is not running. Attempting to restart ${att}..."
restart_process "$1"
if  process_check "$1";then
break
fi 
done
fi
}

process_monitor "$1"


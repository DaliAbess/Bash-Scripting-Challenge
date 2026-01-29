function error_count {
log_file="$1"
error_number=$(grep -c "ERROR" "$log_file")
echo "total errors is : $error_number"
}
function critical_events {
log_file="$1"
critical=$(grep -n "CRITICAL" "$log_file")
echo "$critical"
}
function top_erros { 
log_file="$1"
error_messages=$(grep "ERROR" log_file | cut -d ']' -f2 | cut -d '-' -f1 | sort | uniq -c | sort -nr | head -5)
echo -e "top error messages :\n $error_messages"
}

log_file="$1"

if [ $# -eq 0 ];then
echo "set log_file path"
exit 1
fi
if [ ! -f  "$log_file" ];then
echo "Error: $log_file not exist."
exit 1
fi

summary_report="summary_report_$(date '+%Y-%m-%d').txt"
{
echo "Date of analysis : $(date)" 
echo "log file name : $log_file"
echo "Total lines processed : $(wc -l $log_file)"
error_count "$1"  
top_erros "$1" 
echo "List of critical events :"
critical_events "$1" 
} >  "$summary_report"    

echo "summary report generated in $summary_report"

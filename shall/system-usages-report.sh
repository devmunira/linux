report_dir="../report"

if [[ ! -d "$report_dir" ]]; then
	mkdir -p "$report_dir"
fi


#Generate file name based on timestemp
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
report_file="$report_dir/system_performatce_report_$timestamp.log"

echo $timestamp ,  $report_file

#Collect Data of CPU, Memory & RAM
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}' | xargs printf "%.2f%%")
memory_usage=$(free | grep Mem | awk '{printf("%.2f%%"), $3/$2 * 100}')
disk_usage=$(df -h /home | awk 'NR==2 {print $5}')


# Generate the report
{
    echo "System Performance Report - $(date)"
    echo "---------------------------------"
    echo "CPU Usage: $cpu_usage"
    echo "Memory Usage: $memory_usage"
    echo "Disk Usage: /home ($disk_usage)"
} > "$report_file"

echo "System performance report generated: $report_file"

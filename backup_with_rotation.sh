function backup_rotation {
backuparray=()
backuparray=($(ls -t back_dir))
if [ "${#backuparray[@]}"  -gt 3 ];then 
for i in "${backuparray[@]:3}" 
do 
rm -r "back_dir/$i"
echo "backup deleted: back_dir/$i."
done
fi
}

function display_usage {
echo "the script $0 needs folder name"
}
function create_backup {
   source_dir="$1" 
   local timestamp=$(date '+%Y-%m-%d_%H-%M-%S')  # Get the current timestamp
    local backup_dir="back_dir/backup_${timestamp}"

    # Create the backup folder with the timestamped name
    mkdir "$backup_dir"
    echo "Backup created successfully: $backup_dir"
    cp -r "${source_dir}"/* "$backup_dir"
}
if [ $# -eq 0 ] || [ ! -d "$1" ]; then
    echo "Error: Please provide a valid directory path as a command-line argument."
    display_usage "$0"
    exit 1
fi
create_backup "$1"

backup_rotation 

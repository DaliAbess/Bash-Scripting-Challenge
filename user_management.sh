#!/bin/bash

function Display_usage {
echo "Usage: $0 [OPTIONS]"
echo "-c, --create  create a new user account."
echo "-d, --delete  delete an existing user account."
echo "-r, --reset   reset password for an existing user."
echo "-l, --list    list all user accounts on the system."
echo "-h, --help    display this help and exit."
}
function create_user {

read -p "Enter the new username: " username
if  id "$username" 1>/dev/null 2>/dev/null  ; then
echo "Error: the username '$username' already exist.please choose another username."
else
read -p "Enter the password for $username: " password
sudo useradd -p "$password" -m "$username"
echo "user account '$username' created successfully."  
fi
}

function list_users {
echo "users accounts on the system:"
cat /etc/passwd | awk -F :  '{print $1 "(UID:" $3 ")"}'
} 
function delete_user {
read -p "Enter the user to delete:" username
if  id "$username" ; then
sudo userdel -r "$username"  
echo "the account '$username' successfully deleted."
else
echo "the user $username not exist.please enter a valid user."
fi
}
function reset_password {
read -p "Enter the username to reset password: " username
if id "$username" ; then
read -p "Enter the new password: " password
echo "$username:$password" | sudo chpasswd
echo "password for user $username reset successfully."
else
echo "the user does not exist."
fi
}
while [ "$#" -gt 0 ]; do


case "$1" in 
-c | --create)
create_user ;;
-d | --delete)
delete_user;;
-r | --reset)
reset_password;;
-l | --list)
list_users;;
-h | --help)
Display_usage;;
*)
Display_usage
exit 1 ;;
esac
shift
done
 

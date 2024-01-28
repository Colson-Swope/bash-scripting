#!/bin/bash

# script should check to see how often the apt command is run on a linux system #
# fist the script should check for command line arguments (script path)

# first argument should check for -h

help_screen() {
    echo "Welcome to Apt Log Inspect written by Colson Swope!"
    echo ""
    echo "Usage: "
    echo ""
    echo "-h Display help for program" 
    echo "-u Specify a specific user for the program to search for"
    echo "-s Specify a specific date (in years) for the program to search for"
    exit 0

}

while [ $# -gt 0 ]; do
    case "$1" in
        -f)
            file_path="$2"
            shift #skip the value
            ;;
        -u)
            user="$2"
            shift #skip the value
            ;;
        -h)
            help_screen
            ;;

        -s)
            start_date="$2"
            shift #skip this value
            ;;
        *)
            echo "Apt Log Inspect: Unknown option: $1" >&2
            exit 1
            ;;
    esac
    shift #
done

if [ -z "$file_path" ] && [ -z "$user" ]; then
    echo "Apt Log Inspect: No options provided. Usage: $0 -f <file_path> -u <user> -s <date (year)>" >&2
    exit 2
fi

if [ -n "$file_path" ]; then
    echo "File path specified: $file_path"
fi

if [ -n "$user" ]; then
   echo "Searching log for user specified: $user"
   user_count=$(grep -c "Requested-By: $user" "$file_path")
   echo "User ran this command $user_count times"
fi

if [ -n "$start_date" ]; then
    echo "Searching start date of apt command: $start_date "
    grep "Start-Date: $start_date" "$file_path"
fi



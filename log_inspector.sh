#!/bin/bash

# script should check to see how often the apt command is run on a linux system #
# fist the script should check for command line arguments (script path)

# first argument should check for -h

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
            echo "Welcome to Apt Log Inspect written by Colson Swope!"
            echo ""
            echo "Usage: "
            exit 0
            ;;

        -s)
            start_date="$2"
            shift #skip this value
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
    shift #
done

if [ -z "$file_path" ] && [ -z "$user" ]; then
    echo "No options provided. Usage: $0 -f <file_path> -u <user>"
    exit 1
fi

if [ -n "$file_path" ]; then
    echo "File path specified: $file_path"
fi

if [ -n "$user" ]; then
   echo "Searching log for user specified: $user"
   grep "Requested-By: $user" "$file_path"
fi

if [ -n "$start_date" ]; then
    echo "Searching start date of apt command: $start_date "
    grep "Start-Date: $start_date" "$file_path"
fi



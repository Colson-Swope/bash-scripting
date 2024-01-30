#!/bin/bash

# Colson Swope
# 01/27/2024
																	 																						 #
# This program is titled 'Apt Log Inspect' and it does just that. This script will search the path specified by the user. In this case, it will be the location of the apt log.
# Once the apt log file path has been specified, the program will look for certain flags. The flags that the user is able to choose are -h, -f, -u, and -s. -h provides
# a general overview of the program's function, -f allows the user to specify a custom file path, -u allows the user to specify a certain user to search for in the log,
# and -s allows the user to specify for a certain year that the apt command was ran.


# show user how to use this program
help_screen() {
    echo "Welcome to Apt Log Inspect written by Colson Swope!

    Usage:

    ./log_inspector.sh -f </path/to/apt/file> -u <user> -s <year>

    -f Specify apt log file path
    -h Display help for a program
    -u Specify a specific user for the program to search for
    -s Specify the date command was ran
"
    exit 0
}

# this while loop is used to handle our CMD args
while [ $# -gt 0 ]; do
    case "$1" in
        -f)
            file_path="$2"
            shift #shift the argument over
            ;;
        -u)
            user="$2"
            shift #shift the argument over
            ;;
        -h)
            help_screen
            ;;

        -s)
            start_date="$2"
            shift #shift the argument over
            ;;
        *)
            echo "Apt Log Inspect: Unknown option: $1" >&2
            exit 1
            ;;
    esac
    shift
done

# if we do not provide any options, print this error message
if [ -z "$file_path" ] && [ -z "$user" ] && [ -z "$start_date"]; then
    echo "Apt Log Inspect: No options provided. Usage: $0 -f <file_path> -u <user> -s <date (year)>" >&2
    exit 2
fi

# print out which file path the user entered
if [ -n "$file_path" ]; then
    echo "File path specified: $file_path"
fi

# print out user info, iterate through and count up times user ran apt command
if [ -n "$user" ]; then
   echo "Searching log for user specified: $user"
   user_count=$(grep -c "Requested-By: $user" "$file_path")
   echo "User ran this command $user_count times"
fi

# print out the start date of the apt command
if [ -n "$start_date" ]; then
    echo "Searching start date of apt command: $start_date "
    grep "Start-Date: $start_date" "$file_path"
fi



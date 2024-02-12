#!/bin/bash

# Colson Swope
# 02/10/2024

# the purpose of this script is to provide information to the user comparing process and thread statuses
# provided info must include three different values
# use info from the /proc directory
# support multiple uses, including help option
# options to include:
# -i = display process identical in run-time, memory, etc.
# -d = display process launched from particular directory or directory tree
# -u = display process with identical username characteristics

# References:
#https://www.unix.com/unix-for-dummies-questions-and-answers/43348-determine-pid-ps-ef-grep-something-2.html
#https://linuxize.com/post/ps-command-in-linux/
#https://www.baeldung.com/linux/ps-output-grep-headers#:~:text=The%20ps%20command%20with%20the,command%20to%20do%20some%20filtering.
#https://stackoverflow.com/questions/48161019/bash-script-to-identify-running-process
#https://www.cyberciti.biz/faq/linux-list-processes-by-user-names-euid-and-ruid/

help_screen() {

    echo "Welcome to Process Inspector written by Colson Swope!

    Usage:

    ./process_script.sh -u <username> -i -d

    - i Display process identical in run-time, memory, etc.
    - d Display process launched from particular directory or directory tree
    - u Display process with identical username characteristics
    "

    exit 1

}

# error handling for no flags
if [ $# -eq 0 ]; then
    help_screen
    exit 1
fi

# list processes with similar memory resource utilization
identical_process() {

    ps -eo pid,%cpu,%mem,cmd --sort=-%mem
    exit 0

}

# list processes tied to a specific directory path
directory_process() {

    ps aux | grep "directory_path"
    exit 0

}

# list processes tied to a specific username
username_process() {
    if [ $# -lt 2 ]; then
        echo "Process Inspector Error: Please specify a username" >&2
        help_screen
        exit 1
    fi
    username="$2"
    ps -u "$username"
    exit 0
}

# while loop used for handling CMD arguments
while [ $# -gt 0 ]; do
    case "$1" in
        -h)
            help_screen
            ;;
        -i)
            identical_process
            ;;
        -d)
            directory_process
            ;;
        -u)
            if [ $# -lt 2 ]; then
                echo "Process Inspector Error: Please specify a username after the -u option." >&2
                exit 1
            fi
            username_process "$@"
            ;;
    esac
    shift
done

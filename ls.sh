#! /bin/bash
if [ $# -eq 1 ]; then
        if [ -d $1 ]; then
                tree $1
        else
                echo "Error: User Doesn't exsist" >&2 # &2 is standard error output
        exit 2 # the exit code that shows something wrong happened with the directory
        fi
fi

if [ $# -eq 2 ]; then
        if [ -d $1 ]; then
                cd "$1"
                if [ -d $2 ]; then
                        tree $2
                else
                        echo "Error : No such services available" >&2
                        exit 3
                fi
        else
                echo "Error: User Doesn't exsist" >&2 # &2 is standard error output
        exit 2 # the exit code that shows something wrong happened with the directory
        fi
fi
#!/bin/bash
user=$1
link=""
link_t=""

# this is an example of how to check the arguments
if [ $# -ne 4 ]; then
echo "Error:the number of parameters is wrong" >&2 # &2 is standard error output
exit 1 # the exit code that shows something wrong happened
fi
#check whether the argument leads to a directory...
if ! [ -d $1 ]; then
        echo "Error: User Doesn't exsist" >&2 # &2 is standard error output
        exit 2 # the exit code that shows something wrong happened with the directory
else
        cd $3
        link=`pwd`
        link_t="$link/$2"
        #echo "$link_t is the link"
        file_name="${link_t##*/}"
        #echo "$file_name is the file"
        directory_name="${link_t//$file_name/}"
        #echo "$directory_name is the directory"
        if [ "$3" = "i" ];then #to check its insert or update
                if [ -d "$directory_name" ];then
                                        cd "$directory_name"
                                        if [ -f "$file_name" ]; then
                        echo "Error: Service already exsist"
                                        else
                                                touch "$file_name"
                        echo "$4" >> "$file_name"
                        echo "Ok: Service Created"
                                        fi
                                else
                    mkdir -p "$directory_name"
                    cd "$directory_name"
                    touch "$file_name"
                user=`echo $4 | cut -d ":" -f 1`
                password=`echo $4 | cut -d ":" -f 2`
                    echo -e "login: $user\npassword: $password" >> "$file_name"
                    echo "Ok: Service Created"
                fi
        elif [ "$3" = "f" ];then
                if [ -d "$directory_name" ];then
                                        cd "$directory_name"
                                        if [ -f "$file_name" ]; then
                                                rm -f "$file_name"
                                                touch "$file_name"
                                                 user=`echo $4 | cut -d ":" -f 1`
                                                password=`echo $4 | cut -d ":" -f 2`
                                                echo -e "login: $user\npassword: $password" >> "$file_name"
                                                #echo "$4" >> "$file_name"
                                                echo "Ok: Service Updated"
                                        else
                                                touch "$file_name"
                                                #echo "$4" >> "$file_name"
                                                user=`echo $4 | cut -d ":" -f 1`
                                                password=`echo $4 | cut -d ":" -f 2`
                                                echo -e "login: $user\npassword: $password" >> "$file_name"
                                                echo "Ok: Service Created"
                                        fi
                                else
                    mkdir -p "$directory_name"
                    cd "$directory_name"
                    touch "$file_name"
                    echo "$4" >> "$file_name"
                    echo "Ok: Service Created"
                fi
        fi
fi
# at the end of the script an exit code 0 means everything went well
exit 0
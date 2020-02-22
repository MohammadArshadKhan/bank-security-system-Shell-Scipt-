#! /bin/bash
link=""
link_t=""

# this is an example of how to check the arguments
if [ $# -ne 2 ]; then
echo "Error:the number of parameters is wrong" >&2 # &2 is standard error output
exit 1 # the exit code that shows something wrong happened
fi

#check whether the argument leads to a directory...
if ! [ -d $1 ]; then
        echo "Error: User Doesn't exsist" >&2 # &2 is standard error output
        exit 2 # the exit code that shows something wrong happened with the directory
else
        cd $1
        link=`pwd`
        link_t="$link/$2"
        file_name="${link_t##*/}"
        directory_name="${link_t//$file_name/}"
        if [ -d "$directory_name" ];then
            cd "$directory_name"
            if [ -f "$file_name" ]; then
                                rm -f $file_name
                                echo "Ok: Service Removed"
            else
                echo "Error: Service does not exsist"
            fi
                else
                        echo "Error: Service does not exsist"
                fi
fi
# at the end of the script an exit code 0 means everything went well
exit 0
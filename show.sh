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
        #echo "$link_t is the link"
        file_name="${link_t##*/}"
        #echo "$file_name is the file"
        directory_name="${link_t//$file_name/}"
        #echo "$directory_name is the directory"
        if [ -d "$directory_name" ];then
                        cd "$directory_name"
                        if [ -f "$file_name" ]; then
                                cat $file_name
                        else
                                echo "Error: Service does not exsist"
                        fi
                else
                        echo "Error: Service does not exsist"
                fi
fi
# at the end of the script an exit code 0 means everything went well
exit 0
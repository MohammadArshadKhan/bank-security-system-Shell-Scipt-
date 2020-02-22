#!/bin/bash
if [ $# -lt 2 ]; then
        echo "Error : Parameter Problems"
        exit 1
fi

pipe_server="server.pipe"

if [ ! -e "$pipe_server" ]; then
        echo "Error: Server not started"
        exit 2
fi

trap "exit_interrupted" INT

function exit_interrupted()
{
rm -f "$pipe_server"
exit 0
}

client_id=$1
pipe_client="$client_id".pipe
option=$2

rm -f "$pipe_client"
mkfifo "$pipe_client"

case "$option" in
        init)
                if [ $# -ne 3 ]; then
                echo "Error: parameters problem"
                rm -f "$pipe_client"
                exit 3
                fi
                user_id="$3"
                echo "$client_id $option $user_id" > $pipe_server
                cat "$pipe_client"
                ;;
        insert)
                if [ $# -ne 4 ]; then
                echo "Error: parameters problem"
                rm -f "$pipe_client"
                exit 4
                fi
                echo "Please write login:"
                read login
                if [ -z "$login" ]; then
                        echo "Error: login is not valid."
                        rm -f "$pipe_client"
                        exit 1
                fi
                echo "Please write password:"
                read password
                if [ -z "$password" ];then
                        echo "Error: login is not valid."
                        rm -f "$pipe_client"
                        exit 1

                fi
                user_id="$3"
                service="$4"
                #FILEtemp=`mktemp`
                #echo -e "login: $login\npassword: $password" > "$FILEtemp"
                payload="$login:$password"
                echo "$client_id $option $user_id $service $payload" > "$pipe_server"
                cat "$pipe_client"
                #rm -f "$FILEtemp"
                ;;
        show)
                if [ $# -ne 4 ]; then
                        echo "Error: parameters problem"
                        rm -f "$pipe_client"
                        exit 4
                fi
                user_id="$3"
                service="$4"
                echo "$client_id $option $user_id $service" > "$pipe_server"
                cat "$pipe_client"
                ;;
        update)
                if [ $# -ne 4 ]; then
                echo "Error: parameters problem"
                rm -f "$pipe_client"
                exit 4
                fi
                echo "Please write login:"
                read login
                if [ -z "$login" ]; then
                        echo "Error: login is not valid."
                        rm -f "$pipe_client"
                        exit 1
                fi
                echo "Please write password:"
                read password
                if [ -z "$password" ];then
                        echo "Error: login is not valid."
                        rm -f "$pipe_client"
                        exit 1

                fi
                user_id="$3"
                service="$4"
                #FILEtemp=`mktemp`
                #echo -e "login: $login\npassword: $password" > "$FILEtemp"
                payload="$login:$password"
                echo "$client_id $option $user_id $service $payload" > "$pipe_server"
                cat "$pipe_client"
                #rm -f "$FILEtemp"
                ;;
        rm)
                if [ $# -ne 4 ]; then
                        echo "Error: parameters problem"
                        rm -f "$pipe_client"
                        exit 4
                fi
                user_id="$3"
                service="$4"
                echo "$client_id $option $user_id $service" > "$pipe_server"
                cat "$pipe_client"
                ;;
        ls)
                if [ $# -eq 3  ]; then
                                user_id="$3"
                                echo "$client_id $option $user_id" > "$pipe_server"
                                cat "$pipe_client"
                elif [ $# -eq 4 ]; then
                        user_id="$3"
                        service="$4"
                        echo "$client_id $option $user_id $service" > "$pipe_server"
                        cat "$pipe_client"

                else
                        echo "Error: parameters problem"
                        rm -f "$pipe_client"
                        exit 4
                fi

                ;;
        shutdown)
                if [ $# -ne 2 ]; then
                        echo "Error: parameters problem"
                        rm -f "$pipe_client"
                        exit 4
                fi
                echo "$client_id $option" > "$pipe_server"
                cat "$pipe_client"
                ;;
        *)
                echo "Error: bad request"
                rm -f "$pipe_client"
                exit 1

esac
rm -f "$pipe_client"
exit 0
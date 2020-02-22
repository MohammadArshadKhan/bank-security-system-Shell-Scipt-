#!/bin/bash
PIPE_SERVER="server.pipe"
#creating server pipe if not exists
if [ ! -e "$PIPE_SERVER" ]; then
        mkfifo "$PIPE_SERVER"
fi

trap "exit_interrupted" INT

function exit_interrupted()
{
rm -f "$PIPE_SERVER"
exit 0
}


while true; do
echo "Waiting request....."
read input < "$PIPE_SERVER"
echo "Input Received: $input"

clientId=`echo $input | cut -d " " -f 1`
request=`echo $input | cut -d " " -f 2`




case "$request" in
        init)
                user=`echo $input | cut -d " " -f 3`
        ./init.sh $user > $clientId.pipe &
        ;;

        insert)
                user=`echo $input | cut -d " " -f 3`
        choice="i"
                service=`echo $input | cut -d " " -f 4`
                payload=`echo $input | cut -d " " -f 5`
        echo "$user $service $choice $payload"
        ./insert.sh $user $service $choice $payload > $clientId.pipe &
        ;;

        show)
                user=`echo $input | cut -d " " -f 3`
                service=`echo $input | cut -d " " -f 4`
        ./show.sh $user $service > $clientId.pipe &
        ;;

        rm)
                user=`echo $input | cut -d " " -f 3`
                service=`echo $input | cut -d " " -f 4`
        ./remove.sh $user $service > $clientId.pipe &
        ;;

        ls)
                user=`echo $input | cut -d " " -f 3`
                service=`echo $input | cut -d " " -f 4`
                echo "$user $service"
        ./ls.sh $user $service > $clientId.pipe &
        ;;

                update)
                user=`echo $input | cut -d " " -f 3`
        choice="f"
                service=`echo $input | cut -d " " -f 4`
                payload=`echo $input | cut -d " " -f 5`
        echo "$user $service $choice $payload"
        ./insert.sh $user $service $choice $payload > $clientId.pipe &
        ;;

        shutdown)
        rm -f "$PIPE_SERVER"
                echo "OK: Server is shut down" > $clientId.pipe &
                exit 0
        ;;

        *)
        echo "Error: bad request"
        exit 1
esac
done
rm -f "$PIPE_SERVER"
exit 0
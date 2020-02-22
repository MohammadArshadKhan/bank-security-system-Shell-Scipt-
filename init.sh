#!/bin/bash
if [ "$#" -eq 0 ]; then
echo "Error: Parameter Problem" >&2
exit 1
elif [ "$#" -eq 1 ];then
if [ -d "$@" ]; then
echo "Error: User alredy exsist" >&2
exit 2
else
mkdir -p "$@"
echo "User "$@" created"
fi
else
echo "Error:Parameter Problem" >&2
fi
exit 0
~       
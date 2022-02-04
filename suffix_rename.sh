#!/bin/bash
#script to rename a folders files into another suffix
function print_desc {
  echo "Usage: command, file-suffix in quotes, path or nothing for working dir"
}
#Check if the command argument is set
if [ -z "$1" ]
  then
   echo "Need a command to run the script"
   	print_desc
   exit 0
else
	echo "Using the command: $1"
	command=$1
fi

#Check if the suffix variable is set
if [ -z "$2" ]
  then
	echo "Need a suffix to run the script"
	print_desc
	exit 0
else
	echo "Using the the path: $2"
	suffix="$2"
fi

#Check if the path variable is set
if [ -z "$3" ]
  then
	echo "Using the working path"
	path=$PWD
else
	echo "Using the the path: $3"
	path=$3
fi

echo Using the command:$1 on "$2" files

#Count the number of files
c=`ls -l $path/$suffix | wc -l`

#Append the command on the files
for ((i = 1 ; i <= $c ; i++)); do
	echo $i
	$command `ls -1 $path/$suffix | sed -n "$i"p`
done

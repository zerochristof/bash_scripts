#!/bin/bash
#script for att skapa backup fran mappar med enkel felkorrigering, spara backup i tar.gz filer
#dwvilken mapp tar.gz filerna ska sparas i
BACKUP=$HOME/backups
#Function to print usage information of the script
function print_usa
{
echo "Usage: backups folder, directories to backup,"
}

#Check the arguments that have been set

#Check that a backup folder have beeen specified

#Check that a folder to backup has been specified

#starta loop far mapparna man ska gar backup pa(argumenten)
for var in "$@"
do
 #kontrollera mappen som man ska skapa ett tar arkiv fran
 if [[ -d $var ]]
 then
 #initierar c variabeln som andvands till att bekrafta om ett tar arkiv ska skapas
 c=false
 #en mapp hittades, hamta mapp namnet
 basename "$var"
 foldern="$(basename -- $var)"
 #se om det finns tidigare backups med samma mapp namn i filnamnet
 file=`ls -t $BACKUP/ | grep $foldern | head -n 1`
 echo $file
 if [[ -f "$BACKUP/$file" ]]
 then
 #jamfor den senaste tar filen med mappen, jamforelsen ser om arkivet och det som skapas är lika stora
 c1=`tar -ntf $BACKUP/$file | wc -l`
 c2=`find $var | wc -l`
 if [[ $c1 -ne $c2 ]]
 then
 #tar filen och mappen har inte lika manga filer, c=1 ett tar arkiv ska skapas
 c=true
 echo "olika mangd filer"
 fi
 else
 #inga tar filer hittades c=1 ett tar arkiv ska skapas
 c=true
 echo inga hittade
 fi
 if [ "$c" == true ]
 then
 #det ska skapas ett nytt tar, arkiv andvand mapp namn och datum far tar arkivets namn
 echo "skapa tar arkiv"
 tar -czf "$BACKUP"/"$foldern"_`date "+%m_%d_%y_%h_%H_%M_%S"`.tar.gz $var
 fi
 fi
done
#avsluta

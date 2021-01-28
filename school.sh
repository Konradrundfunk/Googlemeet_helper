#!/bin/bash

if [ "`ping -c 1 1.1.1.1`" ]
then
  notify-send "Internetverbindung steht. Bitte melde dich erst in deinem Broswer an!" &
else
  zenity --warning --text="Kein internet"
  exit 0 
fi

#default is xdg but possible is chrome or firefox
prefbrowser=xdg

faecher=();
links=()
links2=()

FACH=$(zenity --list --title="Unterricht" --column="Fach" ${faecher[@]} );
    exitcode=$?
    declare -i y=1
    if [ "$exitcode" == "1" ];then
        exit 0
    fi
    for i in "${faecher[@]}"
    do   
        if [ "$FACH" = "$i" ]; then
            if [ $prefbrowser == 'chromium' ] ; then
                chromium ${links[((y - 1))]} ${links2[((y - 1))]} & disown
            elif [ $prefbrowser == 'xdg' ]; then
                xdg-open ${links[((y - 1))]} & disown
                xdg-open ${links2[((y - 1))]} & disown
            elif [ $prefbrowser == 'firefox' ]; then
                firefox  ${links[((y - 1))]} ${links2[((y - 1))]} & disown
            else
                echo "Please specify a browser in the shell file!!"
            fi
            break
        fi
        y=$((y + 1))
    done
zenity --question --text "Soll das Programm in Dauerschleife laufen?";loop=$?
while [[ "${loop}" == "0" ]]
do
    FACH=$(zenity --list --title="Unterricht" --column="Fach" ${faecher[@]} );
    exitcode=$?
    if [ "$exitcode" == "1" ];then
        exit 0
        fi 
    declare -i y=1

    for i in "${faecher[@]}"
    
    do   
        if [ "$FACH" = "$i" ]; then
            if [ $prefbrowser == 'chromium' ] ; then
                chromium ${links[((y - 1))]} ${links2[((y - 1))]} & disown
            elif [ $prefbrowser == 'xdg' ]; then
                xdg-open ${links[((y - 1))]} & disown
                xdg-open ${links2[((y - 1))]} & disown
            elif [ $prefbrowser == 'firefox' ]; then
                firefox  ${links[((y - 1))]} ${links2[((y - 1))]} & disown
            else
                echo "Please specify a browser in the shell file!!"
            fi
            break
        fi
        y=$((y + 1))
    done
    sleep 3

done 
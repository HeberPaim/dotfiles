#!/usr/bin/bash

Clock(){
	TIME=$(date "+%H:%M:%S")
	echo -e -n " \uf017 ${TIME}" 
}

Cal() {
    DATE=$(date "+%a, %m %B %Y")
    echo -e -n "\uf073 ${DATE}"
}

ActiveWindow(){
	len=$(echo -n "$(xdotool getwindowfocus getwindowname)" | wc -m)
	max_len=70
	if [ "$len" -gt "$max_len" ];then
		echo -n "$(xdotool getwindowfocus getwindowname | cut -c 1-$max_len)..."
	else
		echo -n "$(xdotool getwindowfocus getwindowname)"
	fi
}

Battery() {
    # Get ACPI information for Battery 0
    BATTACPI=$(acpi --battery | grep "Battery 0")
    BATPERC=$(echo $BATTACPI | cut -d, -f2 | tr -d '[:space:]')

    if [[ $BATTACPI == *"100%"* ]]
    then
        echo -e -n "\uf00c $BATPERC"
    elif [[ $BATTACPI == *"Discharging"* ]]
    then
        BATPERC=${BATPERC::-1} # Remove the '%' symbol for comparison
        if [ $BATPERC -le "10" ]
        then
            echo -e -n "\uf244"
        elif [ $BATPERC -le "25" ]
        then
            echo -e -n "\uf243"
        elif [ $BATPERC -le "50" ]
        then
            echo -e -n "\uf242"
        elif [ $BATPERC -le "75" ]
        then
            echo -e -n "\uf241"
        elif [ $BATPERC -le "100" ]
        then
            echo -e -n "\uf240"
        fi
        echo -e " $BATPERC%"
    elif [[ $BATTACPI == *"Charging"* && $BATTACPI != *"100%"* ]]
    then
        echo -e "\uf0e7 $BATPERC"
    elif [[ $BATTACPI == *"Unknown"* ]]
    then
        echo -e "$BATPERC"
    fi
}


Wifi(){
	WIFISTR=$( iwconfig wlp0s20f3 | grep "Link" | sed 's/ //g' | sed 's/LinkQuality=//g' | sed 's/\/.*//g' )
	if [ ! -z $WIFISTR ] ; then
		WIFISTR=$(( ${WIFISTR} * 100 / 70))
		ESSID=$(iwconfig  wlp0s20f3 | grep ESSID | sed 's/ //g' | sed 's/.*://' | cut -d "\"" -f 2)
		if [ $WIFISTR -ge 1 ] ; then
			echo -e "\uf1eb ${WIFISTR}%"
		fi
	fi
}

Sound(){
	NOTMUTED=$( amixer sget Master | grep "\[on\]" )
	if [[ ! -z $NOTMUTED ]] ; then
		VOL=$(awk -F"[][]" '/dB/ { print $2 }' <(amixer sget Master) | sed 's/%//g')
		if [ $VOL -ge 85 ] ; then
			echo -e "\uf028 ${VOL}%"
		elif [ $VOL -ge 50 ] ; then
			echo -e "\uf027 ${VOL}%"
		else
			echo -e "\uf026 ${VOL}%"
		fi
	else
		echo -e "\uf026 M"
	fi
}

Language() {
    CURRENTLAYOUT=$(setxkbmap -query | grep layout | awk '{print $2}')
    
    # Get the first layout in case there are multiple (separated by a comma)
    CURRENTLANG=$(echo $CURRENTLAYOUT | cut -d, -f1)

    if [[ "$CURRENTLANG" == "us" ]]; then
        echo -e "\uf0ac ENG"
    elif [[ "$CURRENTLANG" == "br" ]]; then
        echo -e "\uf0ac BR"
    else
        echo -e "\uf0ac \uf128"
    fi
}

while true; do
    echo -e "%{l}$(Language) %{c} $(ActiveWindow) %{r} $(Wifi)  $(Battery)  $(Sound)  $(Clock) $(Cal)"
    sleep 0.2
done | lemonbar -g x30 -B#1e001e -F#00FF00 -f"Arial" -f FontAwesome-8

#while true; do
#        echo -e "%{l}$(Language) %{c}$(ActiveWindow) %{r}$(Wifi)  $(Battery)  $(Sound)  $(Clock) $(Cal)"
#	sleep 0.1s
#done
#lemonbar -g -b x30

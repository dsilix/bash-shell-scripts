#!/bin/bash 
						# This shell script can encrypt a lowercase  
						# string of (1-7) char with sha1 or md5 encryption
						# algorithms. With rainbowcrack then checks
						# if the hash is present in the rainbow tables
						# created before and procede to decrypt the string.
						# Made by Silvio Saturno
						# -> github.com/dsilix 

# VARIABLES
folder=/usr/share/rainbowcrack
md5=/usr/share/rainbowcrack/md5/
sha1=/usr/share/rainbowcrack/sha1/
bold=$(tput bold)

# FUNCTIONS
md5(){
	echo "Inserisci una parola: (1-7 caratteri):"
	read parola
	encrypted=$(echo -n $parola | md5sum | awk '{ print $1; }')
	echo -e "${bold}$(tput setaf 3)\n\nL'HASH GENERATO E' $encrypted\n\n $(tput sgr 0)"
	sleep 0.5
	# Ho modificato il comando perchè usando 'rcrack . -h $hash' dava l'errore: 
	# hash algorithm of all input rainbow tables must be identical
	risultato=`rcrack $md5. -h $encrypted | grep hex`
	echo "HASH                              PAROLA:"
	echo "$(tput setab 1)$risultato$(tput sgr 0)"
	echo -e "\n\nRAW:\n\n"
	rcrack $md5. -h $encrypted
}

sha1(){
	echo "Inserisci una parola: (1-7 caratteri):"
	read parola
	encrypted=$(echo -n $parola | sha1sum | awk '{ print $1; }')
	echo -e "${bold}$(tput setaf 3)\n\nL'HASH GENERATO E' $encrypted\n\n $(tput sgr 0)"
	sleep 0.5
	risultato=`rcrack $sha1. -h $encrypted | grep hex`
	echo "HASH                              PAROLA:"
	echo "$(tput setab 1)$risultato$(tput sgr 0)"
	echo -e "\n\nRAW:\n\n"
	rcrack $sha1. -h $encrypted
}

menuShow(){
	echo 
	echo "SCEGLI L'ALGORITMO DI HASHING:"
	echo "1. md5"
	echo "2. sha1"
	echo "3. Quit"
	echo -en "> "
}

mainMenu(){
	i=-1
	while [ "$i" != "3" ]; do
	menuShow
	read i
         i=`echo $i | tr '[A-Z]' '[a-z]'`
        case "$i" in
                "1")
		clear
                md5
                ;;
                "2")
		clear
                sha1
                ;;
                "3")
                exit
                ;;
                *)
		clear
                echo -e "\nSCELTA NON VALIDA!\n"
                ;;
    	    esac
	done
}

cd $folder
mainMenu

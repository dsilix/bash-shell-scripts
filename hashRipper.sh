#!/bin/bash

				# This shell script takes in input
				# a .txt file containing one hash
				# for line and uses Rainbow Tables 
				# to decrypt the hash. You can use
				# your own Rainbow Tables or you can
				# create them from scratch.
				# Made by Silvio Saturno
				# -> github.com/dsilix
#VARIABLES
folder=/usr/share/rainbowcrack
md5=/usr/share/rainbowcrack/md5/
sha1=/usr/share/rainbowcrack/sha1/
bold=$(tput bold)
clear

cd $folder

loadHashGenTable(){
	echo "Inserisci il nome del file:"
	read path
	echo "Vuoi creare una nuova Rainbow Table (y) o usare quelle esistenti (n)?"
	read rispostaTable
	if [[ $rispostaTable == y ]];
	then
		echo "Scegli l'algoritmo:"
		read sceltaAlgo
		if [[ $sceltaAlgo == md5 ]];
		then
			cd $md5
			creaTable 
			rtgen md5 $charset $min $max 0 $chainLen $chainNum 0
			echo -e "${bold}$(tput setab 1)\n\nSORTING\n\n$(tput sgr 0)"
			rtsort . 
			cd $folder
		fi
		if [[ $sceltaAlgo == sha1 ]];
		then
			cd $sha1
			creaTable
			rtgen sha1 $charset $min $max 0 $chainLen $chainNum 0
			echo -e "${bold}$(tput setab 1)\n\nSORTING\n\n$(tput sgr 0)"
			rtsort .
			cd $folder
		fi
	if [[ $rispostaTable == Y ]];
		then
		echo "Verranno usate le Rainbow Tables esistenti"
		sleep 1
	fi
	fi
	clear
}

creaTable(){
	echo "Inserisci il charset (es. loweralpha)"
	read charset
	echo "Inserisci lunghezza minima"
	read min
	echo "Inserisci lunghezza massima"
	read max
	echo "Inserisci lunghezza della catena"
	read chainLen
	echo "Inserisci numero di catene"
	read chainNum
	clear
}

readHash(){
	hashid $risultato 
}

decrypt(){
	echo -e "Decrypted hashes for $path:\n" >> /home/kali/Desktop/cracked.log
	for i in `cat $path`
		do
		risultato=$i 
		readHash 
	        echo -e "\nSeleziona quale algoritmo intendi usare:"
		read algo
		echo
		rcrack /usr/share/rainbowcrack/$algo/. -h $risultato
		sleep 1
		echo $(rcrack /usr/share/rainbowcrack/$algo/. -h $risultato | grep hex | awk '{print $2}' ) >> /home/kali/Desktop/cracked.log
		clear
		done 
	echo -e "________________________________________________________________\n\n" >> /home/kali/Desktop/cracked.log
	echo -e "${bold}$(tput setab 1)\n\nRESULTS SAVED IN /home/kali/Desktop/cracked.log\n\n$(tput sgr 0)"
}

loadHashGenTable
decrypt


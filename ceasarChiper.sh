
#!/bin/bash
				# This shell script takes a string
				# in input and can encrypt it or
				# decrypt it. It uses the Ceaser Chiper
				# Made by Silvio Saturno
				# -> github.com/dsilix
PS3="Choose one:"
options=("Encrypt" "Decrypt" "Quit")
select opt in "${options[@]}"
do
	case $opt in
	"Encrypt")
		echo "Insert the phrase to encrypt:"
		read plain
		echo "Insert your key: (1-26)"
		read n
		if [[ $n -lt 27 ]];
		then
			echo $plain | tr $(printf %${n}s | tr ' ' '.')\A-Z A-ZA-Z  > encrypted.txt
			encrypted=$(head -n 1 encrypted.txt)
			echo -e "The encrypted message is: $encrypted\n"
		else
			echo "MMENTER A NUMBER BETWEEN 1 AND 26!"
		fi
		;;
	"Decrypt")
		echo "Insert the phrase to decrypt (PRESS 'X' TO DECRYPT THE ONE SAVED BEFORE)"
		read phrase
		if [[ $phrase == X || $phrase == x ]]; 
		then
		        echo "Insert your key: (1-26)"
			read z
			if [[ $z -lt 27 ]];
			then
				m="$((26-$z))"
				echo $encrypted | tr $(printf %${m}s | tr ' ' '.')\A-Z A-ZA-Z > decrypted.txt
				decrypted=$(head -n 1 decrypted.txt)
			        echo -e "$decrypted"
			else
				echo "ENTER A NUMBER BETWEEN 1 AND 26!"
			fi

		else
			echo "Insert your key(1-26)"
			read y
			if [[ $y -lt 27 ]];
			then
				y="$((26-$y))"
				echo $phrase | tr $(printf %${y}s | tr ' ' '.')\A-Z A-ZA-Z
			else
				echo "ENTER A NUMBER BETWEEN 1 AND 26!"
			fi
		fi
		;;
	"Quit")	
		break
		;;
	esac
done

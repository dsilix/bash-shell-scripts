#!/bin/bash
                                        # A simple shell script that scans the network
                                        # and looks for hosts with the port 80 opened,
                                        # saves the ip list in a .txt. Change the path in -> file.
                                        # Made by Silvio Saturno
                                        # -> github.com/dsilix
#VARIABLES
file=/home/kali/Desktop/Netgroup/Scripts/raw.txt
open="IP addresses with port 80 opened:"
close="IP addresses with port 80 closed:"
all="ALL HOSTS (UP):"
bold=$(tput bold)

echo "${bold}$(tput setaf 3)EEZY SCANNER $(tput sgr 0)"
#PS3 -> PROMPT USED BY select
PS3='Please enter your choice: '
options=("Run" "Print Results" "Quit")

select opt in "${options[@]}"
        do
                case $opt in
                        "Run")
                                echo "$open" > $file
                                #-oG - produce un output grepabile, awk '{print $2; }' prende il secondo campo
                                # dell'output
                                echo -e "\n"
                                echo -ne '                     (0%)\r'
                                nmap -p 80 -oG - 192.168.0.0/24 | grep 80/open | awk '{ print $2; }' >> $file
                                echo -ne '#####                     (33%)\r'
                                echo -e "\n">>$file
                                echo "$close" >> $file
                                nmap -p 80 -oG - 192.168.0.0/24 | grep 80/close| awk '{ print $2; }' >> $file
                                echo -ne '#############             (66%)\r'
                                echo -e "\n">> $file
                                sleep 1
                                echo -ne '######################### (100%)\r'
                                echo "$all" >> $file
                                #-sn -> skippa port scan, fa vedere gli host up
                                nmap -sn -oG - 192.168.0.0/24 | grep 'Status: Up' | awk '{ print $2; }' >> $file
                                echo "$(tput setaf 1)$(tput setab 7)SCAN SUCCEDED -> results saved in $file$(tput sgr 0)"
                                echo -ne '\n'
                                ;;

                        "Print Results")
                                echo
                                cat $file
                                ;;

                        "Quit")
                                break
                                ;;
                              *)
                                 echo -e "\n"
                                 echo "!!! invalid option RETRY !!!"
                                 echo -e "\n"
                                ;;
                esac
done

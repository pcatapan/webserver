#!/bin/bash

dependencies () {

	PACK_MAN=
	STAT=
	pid=

	while [ -z $PACK_MAN ] 
	do
		echo -n "Enter Name of Your Package Manager (brew , apt, apt-get...): "
		read PACK_MAN
	done

	echo "\x1b[33m       " "+> Please Wait Until Installation Is Done" 

	loading &
	pid=$!

	command -v $PACK_MAN &> /dev/null

	if [ $? = "1" ]
	then
		echo "\x1b[31m" "+> Need To Install suitable package manager for your system to Run this project Perfectly <+" "\033[0m"
		kill $pid
		wait $pid 2>/dev/null
		exit 1
	fi

	command -v php &> /dev/null
	if [ $? = "1" ]
	then
		$PACK_MAN update &> /dev/null
		$PACK_MAN install php
	else
		echo "\x1b[33m       " "+> PHP    : DONE" 
	fi

	command -v python3 &> /dev/null
	if [ $? = "1" ]
	then
		$PACK_MAN update &> /dev/null
		$PACK_MAN install python3
	else
		echo "\x1b[33m        " "+> Python : DONE" 
	fi

	command -v go &> /dev/null
	if [ $? = "1" ]
	then
		$PACK_MAN update &> /dev/null
		$PACK_MAN install go
	else
		echo "\x1b[33m        " "+> Go     : DONE" 
	fi

	kill $pid
	wait $pid 2>/dev/null
	echo ""
	echo ""

	echo ""
	/bin/sleep 1
	echo "\x1b[32m          " "Enviroment Set Completely" "\033[0m"
	printf "\n\n\n"
}

loading () {

	echo ""
	while [ 1 ]
	do
		echo -ne "█"
		sleep 0.1
	done
}

bound="▄▄ ▄▄ ▄▄ ▄▄ ▄▄ ▄▄ ▄▄ ▄▄ ▄▄ ▄▄ ▄▄
░░ ░░ ░░ ░░ ░░ ░░ ░░ ░░ ░░ ░░ ░░"

logo="░██╗░░░░░░░██╗███████╗██████╗░░██████╗███████╗██████╗░██╗░░░██╗
░██║░░██╗░░██║██╔════╝██╔══██╗██╔════╝██╔════╝██╔══██╗██║░░░██║
░╚██╗████╗██╔╝█████╗░░██████╦╝╚█████╗░█████╗░░██████╔╝╚██╗░██╔╝
░░████╔═████║░██╔══╝░░██╔══██╗░╚═══██╗██╔══╝░░██╔══██╗░╚████╔╝░
░░╚██╔╝░╚██╔╝░███████╗██████╦╝██████╔╝███████╗██║░░██║░░╚██╔╝░░
░░░╚═╝░░░╚═╝░░╚══════╝╚═════╝░╚═════╝░╚══════╝╚═╝░░╚═╝░░░╚═╝░░░
"

clear
echo "\033[0;34m" $logo "\033[0m"
echo "\033[0;34m" "[by : pcatapan - aanghel - msciacca]" "\033[0m" && echo ''
dependencies
echo "\033[0;34m" $bound "\033[0m"
exit 0
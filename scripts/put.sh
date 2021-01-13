#!/bin/bash

# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    put.sh                                             :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: vfurmane <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/30 19:05:57 by vfurmane          #+#    #+#              #
#    Updated: 2020/12/30 19:05:57 by vfurmane         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Print a message and exit script
function error()
{
	printf "\033[31m$1\033[0m\n"
	exit 1
}

function warn()
{
	printf "\033[33m$1\033[0m\n"
}

function info()
{
	printf "\033[34m$1\033[0m\n"
}

function usage()
{
	printf "%-13s./run.sh [-b|-c|-h|-l|--no-compile|--no-logs]\n\n" "Usage:"
	printf "options:\n"
	printf "%-13sRun bonus tests.\n" "b"
	printf "%-13sCheck that the tested function is in the right file.\n" "c"
	printf "%-13sDisplay a help message.\n" "h"
	printf "%-13sCompile tests for Linux-based systems.\n" "l"
	printf "%-13sDo not compile the Libft.\n" "no-compile"
	printf "%-13sDo not display error logs if a test fails.\n" "no-logs"
	printf "\n"
	exit 0;
}

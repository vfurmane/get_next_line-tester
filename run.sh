#!/bin/bash

# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    run.sh                                             :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: vfurmane <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/30 19:05:26 by vfurmane          #+#    #+#              #
#    Updated: 2020/12/30 19:05:28 by vfurmane         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Colors
# NC	\e[0m
# RED	\e[31m
# GREEN	\e[32m

# cd to the script's directory
cd "$(dirname "$0")"

# List of every test files
tests=()

# Intro message
source scripts/intro.sh
# Message functions
source scripts/put.sh
# Parse arguments
source scripts/args.sh

info "Compiling the test scripts..."
make all > /dev/null 2>&1 || error "Error when compiling the tests."
texts=$(find test/texts -name "*.txt" -exec sh -c "basename {} | sed 's/.txt$//'" \; | sort)

# Create the directory for test scripts and logs
mkdir -p logs

info "--------[ basic ]--------"
for text in ${texts[@]}
do
	# Check that the script exists or not
	if ls outs/texts/$text.txt > /dev/null 2>&1
	then
		# Execute the test program and write the logs into a dedicated file
		c=$(tail -c 1 outs/texts/$text.txt)
		if [ "$c" != "" ]
		then
			./outs/basic_test.out outs/texts/$text.txt -n > logs/$text.log
		else
			./outs/basic_test.out outs/texts/$text.txt > logs/$text.log
		fi
		# Display OK or KO according to the diff returned value
		diff outs/texts/$text.txt logs/$text.log
		if [ $? -eq 0 ]
		then
			ret_msg=$'\033[32mOK\033[0m'
			printf "%-20s [%s]\n" $text $ret_msg
		else
			ret_msg=$'\033[31mKO\033[0m'
			printf "%-20s [%s]\n" $text $ret_msg
		fi
	else
		warn "Text file for $text doesn't exist."
	fi
done

make clean > /dev/null 2>&1

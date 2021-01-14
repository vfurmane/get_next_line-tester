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

# List of buffer sizes
buff_sizes=(32 1 100 9999 10000000)
# List of every test files
tests=()
# List of fds
fds=(0 3 -1)
# List of expected return
fd_return=(0 1 1)

# Intro message
source scripts/intro.sh
# Message functions
source scripts/put.sh
# Parse arguments
source scripts/args.sh

make fclean > /dev/null 2>&1
texts=$(find test/texts -name "*.txt" -exec sh -c "basename {} | sed 's/.txt$//'" \; | sort)

# Create the directory for test scripts and logs
mkdir -p logs/basic

info "--------[ basic ]--------"
for size in ${buff_sizes[@]}
do
	info "BUFFER_SIZE = $size"
	for text in ${texts[@]}
	do
		make all BUFF_SIZE=$size > /dev/null 2>&1 || error "Error when compiling the tests."
		# Check that the script exists or not
		if ls outs/texts/$text.txt > /dev/null 2>&1
		then
			# Execute the test program and write the logs into a dedicated file
			c=$(tail -c 1 outs/texts/$text.txt)
			if [ "$c" != "" ]
			then
				./outs/basic_test.out outs/texts/$text.txt -n > logs/basic/$text.log
			else
				./outs/basic_test.out outs/texts/$text.txt > logs/basic/$text.log
			fi
			# Display OK or KO according to the diff returned value
			diff outs/texts/$text.txt logs/basic/$text.log
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
	make eclean > /dev/null 2>&1
done

# Create the directory for test scripts and logs
mkdir -p logs/custom_fd

info "-------[ custom_fd ]-------"
info "You need to type text... (Ctrl + D to end)"
for i in ${!fds[@]}
do
	fd=${fds[$i]}
	ret=${fd_return[$i]}
	make all > /dev/null 2>&1 || error "Error when compiling the tests."
	./outs/custom_fd.out $fd > logs/custom_fd/fd_$fd.log 2>&1
	if [ $? -eq $ret ]
	then
		ret_msg=$'\033[32mOK\033[0m'
		printf "%-20s [%s]\n" $fd $ret_msg
	else
		ret_msg=$'\033[31mKO\033[0m'
		printf "%-20s [%s]\n" $fd $ret_msg
	fi
	make eclean > /dev/null 2>&1
done


# Create the directory for test scripts and logs
mkdir -p logs/leaks

info "--------[ leaks ]--------"
make all FSAN="-g3 -fsanitize=address" > /dev/null 2>&1 || error "Error when compiling the tests."
for text in ${texts[@]}
do
	# Check that the script exists or not
	if ls outs/texts/$text.txt > /dev/null 2>&1
	then
		# Execute the test program and write the logs into a dedicated file
		c=$(tail -c 1 outs/texts/$text.txt)
		if [ "$c" != "" ]
		then
			./outs/basic_test.out outs/texts/$text.txt -n > logs/leaks/$text.log 2>&1
		else
			./outs/basic_test.out outs/texts/$text.txt > logs/leaks/$text.log 2>&1
		fi
		# Display OK or KO according to the diff returned value
		diff outs/texts/$text.txt logs/leaks/$text.log > /dev/null
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

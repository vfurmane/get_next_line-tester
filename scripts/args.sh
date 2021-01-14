#!/bin/bash

# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    args.sh                                            :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: vfurmane <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/01/01 13:06:56 by vfurmane          #+#    #+#              #
#    Updated: 2021/01/01 13:06:56 by vfurmane         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Parse arguments
while [ $# -gt 0 ]
do
	case $1 in
		-b|--bonus)
		BONUS=1
		shift;;
		-h|--help)
		printf "version %s\n\n" $(git describe --tags 2> /dev/null || echo "0")
		usage
		shift;;
		*)
		break;;
	esac
done

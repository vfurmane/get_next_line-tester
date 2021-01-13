# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: vfurmane <vfurmane@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/01/13 10:32:22 by vfurmane          #+#    #+#              #
#    Updated: 2021/01/13 18:26:06 by vfurmane         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

SRCS		= $(addprefix test/srcs/, basic_test.c)
OBJS		= $(SRCS:.c=.o)
EXEC		= $(patsubst test/srcs/%, outs/%, $(OBJS:.o=.out))
ASSETS		= test/assets.c
ASSETS_OBJ	= $(ASSETS:.c=.o)
INCL		= test/includes
GNL			= ../get_next_line
CC			= clang
CFLAGS		= -Wall -Wextra -Werror
CP			= cp -f
RM			= rm -f
MKDIR		= mkdir -p

%.o:		%.c
			$(CC) $(CFLAGS) -c $< -o $@ -I $(INCL) -I $(GNL)

outs/%.out:	test/srcs/%.o
			$(MKDIR) outs
			$(CC) $(CFLAGS) -D BUFFER_SIZE=10000 $< $(GNL)/get_next_line*.c $(ASSETS_OBJ) -o $@

all:		$(ASSETS_OBJ) $(EXEC)
			$(CP) -r test/texts outs

clean:
			$(RM) $(OBJS)
			$(RM) $(ASSETS_OBJ)

fclean:		clean
			$(RM) -r logs outs

re:			fclean all

.PHONY:		all clean fclean re
.SECONDARY:	$(OBJS)

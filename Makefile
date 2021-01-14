# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: vfurmane <vfurmane@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/01/13 10:32:22 by vfurmane          #+#    #+#              #
#    Updated: 2021/01/14 17:40:45 by vfurmane         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

SRCS		= $(addprefix test/srcs/, basic_test.c custom_fd.c multi_fd.c)
OBJS		= $(SRCS:.c=.o)
EXEC		= $(patsubst test/srcs/%, outs/%, $(OBJS:.o=.out))
ASSETS		= test/assets.c
ASSETS_OBJ	= $(ASSETS:.c=.o)
INCL		= test/includes
GNL			= ../get_next_line
GNL_SRCS	= $(GNL)/get_next_line.c $(GNL)/get_next_line_utils.c
GNL_BONSRCS	= $(GNL)/get_next_line_bonus.c $(GNL)/get_next_line_utils_bonus.c
CC			= clang
CFLAGS		= -Wall -Wextra -Werror
FSAN		=
BUFF_SIZE	= 32
CP			= cp -f
RM			= rm -f
MKDIR		= mkdir -p

%.o:		%.c
			$(CC) $(CFLAGS) -c $< -o $@ -I $(INCL) -I $(GNL)

outs/%.out:	test/srcs/%.o
			$(MKDIR) outs
			$(CC) $(CFLAGS) $(FSAN) -D BUFFER_SIZE=$(BUFF_SIZE) $< $(GNL_SRCS) $(ASSETS_OBJ) -o $@

all:		$(ASSETS_OBJ) $(EXEC)
			$(CP) -r test/texts outs

bonus:		GNL_SRCS=$(GNL_BONSRCS)
bonus:		all

clean:
			$(RM) $(OBJS)
			$(RM) $(ASSETS_OBJ)

eclean:		clean
			$(RM) -r outs

fclean:		eclean clean
			$(RM) -r logs

re:			fclean all

.PHONY:		all bonus clean fclean re
.SECONDARY:	$(OBJS)

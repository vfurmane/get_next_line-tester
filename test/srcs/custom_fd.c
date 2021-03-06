/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   custom_fd.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: vfurmane <vfurmane@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/01/13 10:19:44 by vfurmane          #+#    #+#             */
/*   Updated: 2021/01/14 14:39:55 by vfurmane         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "tests.h"

int	main(int argc, char **argv)
{
	int		fd;
	int		ret;
	char	*line;

	if (argc < 2 || argc > 3)
		return (ft_error("Please specify a fd to use..."));
	fd = atoi(argv[1]);
	while ((ret = get_next_line(fd, &line)))
	{
		if (ret == -1)
			return (ft_error("get_next_line failed..."));
		if (argc == 3 && strcmp(argv[2], "-n") == 0)
			printf("%s", line);
		else
			printf("%s\n", line);
		free(line);
	}
	free(line);
	return (0);
}

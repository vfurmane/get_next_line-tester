/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   multiple_small_lines.c                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: vfurmane <vfurmane@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/01/13 10:19:44 by vfurmane          #+#    #+#             */
/*   Updated: 2021/01/13 17:25:16 by vfurmane         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "tests.h"

int	main(int argc, char **argv)
{
	int		fd;
	int		ret;
	char	*line;

	if (argc != 2)
		return (ft_error("Please specify one file to open..."));
	if ((fd = open(argv[1], O_RDONLY)) == -1)
		return (ft_error("Cannot open the file for reading... Run this script from the root of the tester"));
	while ((ret = get_next_line(fd, &line)))
	{
		if (ret == -1)
			return (ft_error("get_next_line failed..."));
		printf("%s\n", line);
		free(line);
	}
	close(fd);
	return (0);
}
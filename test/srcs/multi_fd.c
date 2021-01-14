/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   multi_fd.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: vfurmane <vfurmane@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/01/13 10:19:44 by vfurmane          #+#    #+#             */
/*   Updated: 2021/01/14 17:41:40 by vfurmane         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "tests.h"

int	main(int argc, char **argv)
{
	int		fd1;
	int		fd2;
	int		ret1;
	int		ret2;
	char	*line1;
	char	*line2;

	if (argc != 3)
		return (ft_error("Please specify two files to open..."));
	if ((fd1 = open(argv[1], O_RDONLY)) == -1)
		return (ft_error("Cannot open the first file for reading... Run this script from the root of the tester"));
	if ((fd2 = open(argv[2], O_RDONLY)) == -1)
		return (ft_error("Cannot open the second file for reading... Run this script from the root of the tester"));
	while (1)
	{
		if (fd1 != -1)
		{
			ret1 = get_next_line(fd1, &line1);
			if (ret1 == -1)
				return (ft_error("get_next_line failed..."));
			printf("%s\n", line1);
			fd1 = ret1 ? fd1 : -1;
			free(line1);
		}
		if (fd2 != -1)
		{
			ret2 = get_next_line(fd2, &line2);
			if (ret2 == -1)
				return (ft_error("get_next_line failed..."));
			printf("%s\n", line2);
			fd2 = ret2 ? fd2 : -1;
			free(line2);
		}
		if (fd1 == -1 && fd2 == -1)
			break ;
	}
	close(fd1);
	close(fd2);
	return (0);
}

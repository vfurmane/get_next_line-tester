/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   one_small_line.c                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: vfurmane <vfurmane@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/01/13 10:19:44 by vfurmane          #+#    #+#             */
/*   Updated: 2021/01/13 12:13:37 by vfurmane         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "tests.h"

int	main(void)
{
	int		fd;
	int		ret;
	char	*line;

	if ((fd = open("outs/texts/towel.txt", O_RDONLY)) == -1)
		return (ft_error("Cannot open the file for reading... Run this script from the root of the tester"));
	if ((ret = get_next_line(fd, &line)) == -1)
		return (ft_error("get_next_line failed..."));
	printf("%s\n", line);
	free(line);
	close(fd);
	return (0);
}

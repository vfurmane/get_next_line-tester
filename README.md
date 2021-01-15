# get_next_line Tester

This repo provides test scripts for your **get_next_line** (project at @42Paris). These tests were designed by students (cf. [Credits](#Credits)).

## Installation

First things first, clone this repo alongside the **get_next_line**'s directory.

```shell
git clone https://github.com/vfurmane/get_next_line-tester
```

The file tree should look like this.

```
.
+-- get_next_line
    +-- get_next_line.c
    +-- get_next_line.h
    +-- get_next_line_utils.c
    +-- [get_next_line_bonus.c]
    +-- [get_next_line_bonus.h]
    +-- [get_next_line_utils_bonus.c]
+-- get_next_line-tester
```

However, you can change the **get_next_line**'s path in the `Makefile`.

> Note that the tester doesn't check the norm. The purpose of this repo is to be more effective in evaluation, not to botch it up.

## Usage

Once the installation is done, `cd` into the tester's directory, and run the `./run.sh` script. You will be able to see which function passed or failed. 

The logs are stored in the `logs` directory.

### Arguments

#### -b | --bonus

This arguments runs the bonus tests too.

```shell
./run.sh -b
```

#### -h | --help

Not sure I need to describe this one.

> It prints a help message.

## Troubleshooting

### Error when compiling the tests.

You can see this error message for several reasons:

- Your **get_next_line**'s path in the **Makefile** is wrong.

To see what is wrong, try running `make`.

### I have another problem

If you encounter another problem, please feel free to open an Issue using the **GitHub**'s tab.

## Credits

- [vfurmane](https://github.com/valfur03)

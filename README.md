# DNSGEN Wrapper
A bash wrapper for dnsgen to help place a file size limit on the alterations.

[![version](https://img.shields.io/badge/version-1.1.1-green.svg)](https://semver.org)

You can find dnsgen [here](https://github.com/ProjectAnte/dnsgen)

# Description
I built this because I use DNSgen quite often. However, due to limited space, sometimes the alterations file can be extremely large. To help combat this issue I created this wrapper that will allow the user to set a max file size limit on the file. The wrapper will continuously check the file size and once the max limit is reached, it will stop dnsgen altogether. Of course this may result in some alterations from never happening, but it also helps protect devices with smaller hard drive space, from being over loaded.

**You may need to ctrl+z to fully stop the script. In some test cases, ctrl+c was enough, while others, ctrl+z was needed.**

### Special Note
You can edit your dnsgen command on lines 180 and 184.

# Usage
```
[ usage ]: dnsgen_wrapper.sh -f [filename] -o [outfile] -s [size limit in MB]

optional arguments:
	-h		Show this help message and exit.
	-f		Specify file name full of URLs.
	-o		Specify file to write results to.
	-s		Specify Max file size limit in MB.
	-u		Uniquely sort file after alternations finish.
	-v		Turn on verbose mode.
	-n		Turn off color mode.
	-V		Print version information.

```

# Example usage

### Basic usage
```
bash dnsgen_wrapper.sh -f [file with domains] -o [output file] -s [max size limit in MB]
```

### optional arguments
```
-v [turn on verbose mode] || -n [turn off color mode] || -u [uniquely sort files]
```

```
-v
``` 
To display errors and alterations.

---------------------

```
-u
```
This flag will attempt to sort the alterations file. It is important to note that if your file is bigger than half of your free space, it will fail to sort. For example, if you have 30GB hard drive space available, you should set your file to stop at 14500. Why? Because it will more than likely go over 14500 by a couple KB or MB and you will need the size of the alterations file in free space to properly sort the alterations file.
### Display help menu
```
bash dnsgen_wrapper.sh -h
```

# See where current file size is at:

To see where the current file size is at:
```
ctrl+c
```
will breifly display the file size of the alterations file in MB, on most systems. WARNING: This may stop the program as well.

# To stop the program:

To stop the alterations before the file size is met:
```
CTRL+z.
```

# Tested

Tested on Ubuntu Server 21

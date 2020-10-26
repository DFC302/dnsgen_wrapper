# DNSGEN Wrapper
A bash wrapper for dnsgen to help place a file size limit on the alterations.

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
        -h              Show this help message and exit.
        -f              Specify file name full of URLs.
        -o              Specify file to write results to.
        -s              Specify Max file size limit in MB.
        -v              Turn on verbose mode.
        -n              Turn off color mode.
```

# Example usage

### Basic usage
```
bash dnsgen_wrapper.sh -f [file with domains] -o [output file] -s [max size limit in MB]
```

### optional arguments
```
-v [turn on verbose mode] || -n [turn off color mode]
```

### Display help menu
```
bash dnsgen_wrapper.sh -h
```

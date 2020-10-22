#!/bin/bash

# Set colors
red="\033[0;31m" # For errors
orange="\033[0;33m" # For info
green="\033[0;32m" # For processes
cyan="\033[0;36m" # For display info
nc='\033[0m' # reset

# Display help menu
function usage() {

	# If user does not want color
	if [[ ${no_color} -ne 1 ]] ; then
		echo -e "\n"
		echo -e "${orange}[ usage ]:${nc} ${cyan}dnsgen_wrapper.sh -f [filename] -o [outfile] -s [size limit in MB]${nc}\n"

		echo -e "${orange}optional arguments:${nc}"
		echo -e "\t${orange}-h${nc}\t\t${cyan}Show this help message and exit.${nc}"
		echo -e "\t${orange}-f${nc}\t\t${cyan}Specify file name full of URLs.${nc}"
		echo -e "\t${orange}-o${nc}\t\t${cyan}Specify file to write results to.${nc}"
		echo -e "\t${orange}-s${nc}\t\t${cyan}Specify Max file size limit in MB.${nc}"
		echo -e "\t${orange}-v${nc}\t\t${cyan}Turn on verbose mode.${nc}"
		echo -e "\t${orange}-n${nc}\t\t${cyan}Turn off color mode.${nc}"
		echo -e "\n"

		exit

	# If user does want color
	elif [[ ${no_color} -eq 1 ]] ; then
		echo -e "\n"
		echo -e "[ usage ]: dnsgen_wrapper.sh -f [filename] -o [outfile] -s [size limit in MB]\n"

		echo "optional arguments:"
		echo -e "\t-h\t\tShow this help message and exit."
		echo -e "\t-f\t\tSpecify file name full of URLs."
		echo -e "\t-o\t\tSpecify file to write results to."
		echo -e "\t-s\t\tSpecify Max file size limit in MB."
		echo -e "\t-v\t\tTurn on verbose mode."
		echo -e "\t-n\t\tTurn off color mode.${nc}"
		echo -e "\n"

		exit

	fi
}

# Start dnsgen with file limit size
function _dnsgen() {

	# Check if filename exists, if not let user know
	if [ ! -f ${f} ] ; then

		# if verbose mode is on and no color on
		if [[ ${verbose} -eq 1 && ${no_color} -eq 1 ]] ; then
			echo "[ error ]: -f: File not found!"
			usage

		# if verbose mode is on and no color off
		elif [[ ${verbose} -eq 1 && ${no_color} -ne 1 ]] ; then
			echo -e "{red}[ error ]:${nc} ${orange}-f:${nc} ${cyan}File not found!${nc}"
			usage

		# If verbose mode off just call help menu
		else
			usage

		fi
	fi

	# Check if outfile exists, if not create it
	if [ ! -f ${o} ] ; then

		# If verbose mode is on and no color mode set
		if [[ ${verbose} -eq 1 && ${no_color} -eq 1 ]] ; then
			echo "Could not find outfile. Creating it now..."
			touch ${o}

		# If verbose mode on and color enabled
		elif [[ ${verbose} -eq 1 && ${no_color} -ne 1 ]] ; then
			echo -e "${red}[ error ]:${nc} ${orange}-o:${nc} ${cyan}Could not find outfile. Creating it now...${nc}"
			touch ${o}

		# If verbose mode off, just create file
		else
			touch ${o}

		fi
	fi

	# Set size specified by user to variable
	maxSize=${s}

	# So user has some idea something is happening...

	# If verbose mode is not on and no color enabled
	if [[ ${verbose} -ne 1 && ${no_color} -eq 1 ]] ; then
		echo "Processing now..."

	# If verbose mode not on and color mode is set
	elif [[ ${verbose} -ne 1 && ${no_color} -ne 1 ]] ; then
		echo -e "${green}Processing now...${nc}"

	fi

	# Check size, if size equals or goes over maxsize value, break loop
	while true ; do

		# Check file size
		actualSize=$(du -m ${o} | cut -f1)

		# If verbose mode is on and no colors 
		if [[ ${verbose} -eq 1 && ${no_color} -eq 1 ]] ; then
			echo -e "\nActual size of file: ${actualSize}"
			echo "Max size file limit set at: ${maxSize}"

		# If verbose mode is on and colors on
		elif [[ ${verbose} -eq 1 && ${no_color} -ne 1 ]] ; then
			echo -e "\n${orange}Actual size of file:${nc} ${cyan}${actualSize}${nc}"
			echo -e "${orange}Max size file limit set at:${nc} ${cyan}${maxSize}${nc}"

		fi

		# If file size hits or manages to go over a little maxsize
		if [[ ${actualSize} -ge ${maxSize} ]] ; then
			echo -e "Max file size reached!"
			exit

		# If user has verbose mode enabled, display all alterations
		elif [[ ${verbose} -eq 1 ]] ; then
			cat ${f} | dnsgen - | tee -a ${o}

		# If user does not have verbose mode on, do not display alterations
		elif [[ ${verbose} -ne 1 ]] ; then
			cat ${f} | dnsgen - >> ${o}

		fi

	done

}

# Set command line options
while getopts ":f:o:s:c:hvnc" options; do
	case "${options}" in
		# File with domains
		f)	
			f=${OPTARG}
			;;

		# Send results to file
		o)
			o=${OPTARG}
			;;

		# Set size of file limit in MB
		s)
			s=${OPTARG}
			;;

		# Print help menu
		h)
			usage
			;;

		# Turn on verbose mode
		v)
			verbose=1
			;;

		# Turn off colors
		n)
			no_color=1
			;;

		# Handle everything else
		?)
			usage
			;;

		*)
			usage
			;;
	esac
done

shift "$((OPTIND -1))"

# Display error messages accordingly...

if [[ -z ${f} ]] ; then

	if [[ ${no_color} -eq 1 ]] ; then
		echo "File containing URLs to mutate needed!"
		exit 1

	else
		echo -e "File containing URLs to mutate needed!"
		exit 1

	fi

elif [[ -z ${o} ]] ; then

	if [[ ${no_color} -eq 1 ]] ; then
		echo "Output file needed!"
		exit 1

	else
		echo "Output file needed!"
		exit 1

	fi

elif [[ -z ${s} ]] ; then

	if [[ ${no_color} -eq 1 ]] ; then
		echo "Max file size needed!"
		exit 1

	else
		echo "Max file size needed!"
		exit 1
	fi

elif [[ ${f} && ${o} && ${s} ]] ; then
	_dnsgen

fi

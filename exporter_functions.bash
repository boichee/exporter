#!/bin/bash
# Package: Exporter
# File: /exporter_functions.bash
# Description:
# This file contains the functions that do the work in this application:
# 1. A function that reads the environment vars into the shell configuration
# 2. A function that adds new env vars to the storage file


# If user has not predefined the location of the env vars storage file, set the default location
if [ -z $ENV_VARS_STORAGE_FILE ]; then
	ENV_VARS_STORAGE_FILE = "$HOME/.exporter_environment_variables.data"
fi


# This function simply adds variables to your environment vars file

addVarToEnvironment() {
	if [ "$#" -ne "2" ]; then
		echo "Error! You must specify two arguments" 
		echo "Usage: $0 <env var name> <env var value>";
		exit 1 # End process with error status
	fi

	# If we're here, user has passed the correct number of arguments, but we still have to check to make sure that what the user passed for the var name was a valid string
	if [[ "$1" =~ ^[0-9]{1,} ]] || [[ "$1" =~ \s{1,} ]]; then
		# The env variable name starts with a number or contains spaces
		echo "Error! Variable name formatted incorrectly. Please try again."
		exit 1
	fi

	# Ok, so now we should be all set to continue.

	# First step: write the new variable to the storage file
	local var_statement="export ${1}=${2}"
	echo "${var_statement}" >> "$ENV_VARS_STORAGE_FILE"

	# Next step: Load that variable into the environment
	export "${1}=${2}"

	# That's it! We are done!
}

# This alias will be how you call this function
alias exporter_add='addVarToEnvironment'



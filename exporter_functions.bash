#!/bin/bash
# Package: Exporter
# File: /exporter_functions.bash
# Description:
# This file contains the functions that do the work in this application:
# 1. A function that reads the environment vars into the shell configuration
# 2. A function that adds new env vars to the storage file


# If user has not predefined the location of the env vars storage file, set the default location
if [ -z "$EXPORTER_VARIABLE_STORAGE" ]; then
	EXPORTER_VARIABLE_STORAGE="$HOME/.exporter/exporter_environment_variables.data"
fi


# This function simply adds variables to your environment vars file

addVarToEnvironment() {
	if [ "$#" -ne "2" ]; then
		echo "Error! You must specify two arguments" 
		echo "Usage: $0 <env var name> <env var value>";
		return 1
		kill -INT $$
	fi

	# If we're here, user has passed the correct number of arguments, but we still have to check to make sure that what the user passed for the var name was a valid string
	if [[ "$1" =~ ^[0-9]{1,} ]] || [[ "$1" =~ \s{1,} ]]; then
		# The env variable name starts with a number or contains spaces
		echo "Error! Variable name formatted incorrectly. Please try again."
		return 2
		kill -INT $$
	fi

	# Ok, so now we should be all set to continue.

	# First step: write the new variable to the storage file
	local var_statement="export '${1}=${2}'"
	echo "${var_statement}" >> "$EXPORTER_VARIABLE_STORAGE"

	# Next step: Load that variable into the environment
	export "${1}=${2}"

	# That's it! We are done!
}

# This alias will be how you call this function
alias exporter_add='addVarToEnvironment'



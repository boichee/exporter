#!/bin/bash
# Package: Exporter
# File: /exporter.bash
# Description:
# This file does the main work of creating the .env file that enviroment vars are actually stored in
# It also adds the 2 functions that make this possible:
# 1. A function that reads the environment vars into the shell configuration
# 2. A function that adds new env vars to the storage file


# Ok, first step, add the new functions into the shell config file
echo "Do you use bash or zsh?"
# Now loop and ask for input until a valid answer is entered
while true; do
	read -p "Enter answer (bash|zsh):" -r REPLY
	case $REPLY in
		b|bash|BASH|Bash)
			shell_config_file="$HOME/.bash_profile"
			break
		;;
		z|zsh|ZSH|Zsh)
			shell_config_file="$HOME/.zshrc"
			break
		;;
		*)
			echo "You didn't enter a valid value!"
	esac
done

# Copy the exporter functions file into home dir
EXPORTER_FUNCTIONS_FILE="$HOME/.exporter_functions.bash"
cp "exporter_functions.bash" "$EXPORTER_FUNCTIONS_FILE"

# Set location of storage file (default)
ENV_VARS_STORAGE_FILE="$HOME/.exporter_environment_variables.data"

# Copy the storage file onto the user's computer
cp "exporter_environment_variables.data" "${ENV_VARS_STORAGE_FILE}"


cat <<-ADDTOSHELL >> $shell_config_file
	# Change this line if you change the name or location of the exporter functions file
	EXPORTER_FUNCTIONS_FILE=${EXPORTER_FUNCTIONS_FILE}

	# Added by Exporter to Help You Add new Global Env Vars
	source ${EXPORTER_FUNCTIONS_FILE}

	# If you change the name or location of the exporter vars storage file, please change the location in this line as well.
	export ENV_VARS_STORAGE_FILE="$ENV_VARS_STORAGE_FILE"

	# This line actually does the work of loading the environment variables
	source ${ENV_VARS_STORAGE_FILE}
ADDTOSHELL

# Now actually load any environment vars already in the ENV_VARS_STORAGE_FILE
source "${ENV_VARS_STORAGE_FILE}"

# Done!

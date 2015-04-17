#!/bin/bash
# Package:
#   ____  _  _  ____   __  ____  ____  ____  ____ 
#  (  __)( \/ )(  _ \ /  \(  _ \(_  _)(  __)(  _ \
#   ) _)  )  (  ) __/(  O ))   /  )(   ) _)  )   /
#  (____)(_/\_)(__)   \__/(__\_) (__) (____)(__\_)
#
# File: /exporter.bash
# Description:
# This file does the main work of creating the file where enviroment vars are actually stored
# It also adds a function that adds new env vars to the storage file

# Get the current directory
EXPORTER_DIR="$(echo "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )")"

# Let people know what's going on:

echo "You're about to install:"
echo -e ' ____  _  _  ____   __  ____  ____  ____  ____ ';
echo -e '(  __)( \/ )(  _ \ /  \(  _ \(_  _)(  __)(  _ \';
echo -e ' ) _)  )  (  ) __/(  O ))   /  )(   ) _)  )   /';
echo -e '(____)(_/\_)(__)   \__/(__\_) (__) (____)(__\_)';
echo
echo

# Ok, first step, add the new functions into the shell config file
echo "Before we can install, please tell us..."
echo "Do you use Bash or Zsh as your default shell?"
# Now loop and ask for input until a valid answer is entered
while true; do
	read -p "Enter answer (bash|zsh):" -r REPLY
	case $REPLY in
		b|bash|BASH|Bash)
			$shell_in_use="Bash"
			shell_config_file="$HOME/.bash_profile"
			break
		;;
		z|zsh|ZSH|Zsh)
			$shell_in_use="Zsh"
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


cat <<-ADDCONFIG >> $EXPORTER_DIR/exporter_config

	# Change this line if you change the name or location of the exporter functions file
	EXPORTER_FUNCTIONS_FILE=${EXPORTER_FUNCTIONS_FILE}

	# Now load the exporter functions file
	source ${EXPORTER_FUNCTIONS_FILE}

	# If you change the name or location of the exporter vars storage file, please change the location in this line as well.
	export ENV_VARS_STORAGE_FILE="$ENV_VARS_STORAGE_FILE"

	# This line actually does the work of loading the environment variables
	source ${ENV_VARS_STORAGE_FILE}

ADDCONFIG

# Now copy the config file into teh home directory
cp "${EXPORTER_DIR}/exporter_config" "${HOME}/.exporter_config"

cat <<-SHELLSETUP >> $shell_config_file
	# Added by Exporter
	# ---------------------------------------------------------------
	source "${HOME}/.exporter_config"
SHELLSETUP

# Now actually load any environment vars already in the ENV_VARS_STORAGE_FILE
cat <<-MSG
	Exporter setup is complete!

	Exporter makes adding variables to your shell environment fast and easy.
	And those variables will be permanently added to your environment.

	To use Exporter, open a ${shell_in_use} prompt, and type:
	exporter_add NAME_OF_ENV_VAR VALUE_OF_ENV_VAR

	NOTE:
	Before you can use Exporter for the first time, you MUST open a 
	new terminal window, OR you can type 'source ${shell_config_file}' 
	at the prompt in this window.

	Enjoy!
MSG

# Done!

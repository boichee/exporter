#!/bin/bash
# Package:
#   ____  _  _  ____   __  ____  ____  ____  ____ 
#  (  __)( \/ )(  _ \ /  \(  _ \(_  _)(  __)(  _ \
#   ) _)  )  (  ) __/(  O ))   /  )(   ) _)  )   /
#  (____)(_/\_)(__)   \__/(__\_) (__) (____)(__\_)
#
# File: /uninstall.bash
# Description:
# This file removes exporter and the things it installs

# First let's just remove the additional files that exporter installs for you.
rm $HOME/.exporter_config $HOME/.exporter_functions.bash $HOME/.exporter_environment_variables.data

# Now remove the line that was added to .zshrc
FILES_TO_MOD=("$HOME/.zshrc" "$HOME/.bash_profile")

# This does the same actions for both zshrc and bash_profile so we make sure we get em both!
for file in "${FILES_TO_MOD[@]}"; do

# Make a backup of the config file... just in case things go bad.
cp ${file} ${file}.exporter_uninstall_backup

# Thought of a better way to delete the code Exporter adds to the config files. Way more elegant, and only requires one operation in awk (rather than 5 in sed)
# We know that the inserted code starts with a comment line that reads "Added by Exporter" so we start there
# Then we have awk find that line and we store it in a var called "line",
# And since we also know the inserted code is only 3 lines, we just tell awk not to print that line, plus two more
# Then the uninstaller writes the output from Exporter to a tmp file, and then we move rename that file to be the config file,
# in turn overwriting the original (and effectively deleting the lines we didn't want.)

awk '/Added by Exporter/ {line=NR} { if(NR < line || NR > line + 2 ) print NR, $0}' "${file}" > tmp && mv tmp "${file}"
done;

# Let the user know exporter has been uninstalled.

echo "Thanks for trying..."
echo
echo -e ' ____  _  _  ____   __  ____  ____  ____  ____ ';
echo -e '(  __)( \/ )(  _ \ /  \(  _ \(_  _)(  __)(  _ \';
echo -e ' ) _)  )  (  ) __/(  O ))   /  )(   ) _)  )   /';
echo -e '(____)(_/\_)(__)   \__/(__\_) (__) (____)(__\_)';
echo
echo

cat <<-BYEMSG
	Uninstall is complete. Your system is now clean.

	Because Exporter added a few configuration directives to your shell configuration file, those directives were removed by the uninstaller.

	However, if somehow your shell config file was damaged due to this uninstaller, please be aware that a backup of the file was created prior to the changes being made.

	The configuration backup was named (depending upon which shell you use):
	{.bash_profile,.zshrc}.exporter_uninstall_backup

BYEMSG

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

# First we set up our regular expression var
re=$(echo "$HOME/.exporter_config" | tr '/' ':' | sed 's|:|\\/|g')

# Now use sed, with the regular expression we just created to read in our 
sed "/$re/d" < "${file}" > tmp && mv tmp "${file}"


# These next two lines remove the heading that exporter adds to your configuration files
sed "/Added by Exporter/d" < "${file}" > tmp && mv tmp "${file}"
sed '/# ---------------------------------------------------------------EXPORTER/d' < "${file}" > tmp && mv tmp "${file}"

done;

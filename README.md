# Exporter

A simple application that allows you to quickly and permanently add variables to your shell environment.

# To get started using EXPORTER, just complete the following steps:

1. Clone this repository onto your computer (`git clone`)
2. `cd` into the directory with the `exporter` repository
3. At a shell prompt (Bash or Zsh) type `./install.bash`

That's it! Exporter is installed.

NOTE: You'll have to refresh your terminal environment before Exporter will work. You can do this by opening a new terminal window, or by typing:

```bash

# For Bash users
source ~/.bash_profile

# For Zsh users
source ~/.zshrc

```


Once you complete that step, Exporter will be ready to go.

To use Exporter, you simply type the following at a shell prompt:

```bash
exporter_add ENV_VAR_NAME ENV_VAR_VALUE
```

Where:
`ENV_VAR_NAME` is the name of the environment variable you want to create.
`ENV_VAR_VALUE` is the value you want to set for the environment variable.

So, for example, typing

```bash
exporter_add FB_API_KEY 123456789ABCD
```

Will add the environment variable `FB_API_KEY` into your environment and give it the value `123456789ABCD`.

You can always confirm that exporter_add has succeeded by typing `env` at a terminal prompt. If you see your variable in the list, you are good to go.



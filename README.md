## DotFiles
This is a repository for backup of my dotfiles. Im using this to centralize and not reconfigure all my tools.

To use the files, clone this repository and go to the directory where the configuration file should be. 

As a example, to use .bashrc file on linux, the following commands should work
```bash
# change the directory to $HOME
cd ~

# change name of the .bashrc to .bashrc.bkp to not lose any settings
mv .bashrc .bashrc.bkp

# creates a link of name .bashrc on the ~/ directory, which refers to the file .bashrc on ~/.dotfiles
ln -s ~/.dotfiles/.bashrc ~/.bashrc

```

#### What's next
As for the future, I plan to do a script that sets all files where they should be and install any dependencies to my projects.

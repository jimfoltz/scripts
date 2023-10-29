Scripts for working in Windows cmd.exe
======================================

Several of these scripts rely on external utilites. I highly recommend these tools if you are working regularly on the Windows command line.


* fd - https://github.com/sharkdp/fd
* fzf - https://github.com/junegunn/fzf
* scoop - https://scoop.sh
* Ruby - https://rubyinstaller.org

# Scripts

## ps.cmd

Interactive process viewer/killer. 

`ps.cmd` uses the `tasklist` command to generate a list of processes.  Use the function keys to kill processes.

requires: [fzf, fd]


## scoopfz.cmd

Interactive scoop browser. Fuzzy search, install and uninstall scoop apps.  `update` runs `scoop update *` and updates the scoopfz database.

Press `ctrl-u` to update the app list.


requires: [scoop, fzf, Ruby]

## tg.rb

termgraph - simple graphs for your terminal. [More](./doc/tg.md).

Inspired by https://github.com/mkaz/termgraph

requires: [Ruby]


## get-blender-alpha.rb

Download and unzip the latest Blender alpha.  Also create a cli command `blender-alpha`.  Manually configure the file to customize the location of blender and the command.

requires: [Ruby, unzip, curl]


## w4.rb

Weather Forcast.

Fetch the weeks weather forecast from weather.gov.  For now you'll need to edit the file for your location.  Check the weather.gov API for more information.

requires: [Ruby, your tax dollars]


## fcd.cmd

fuzzy change directory. 

Interactive fuzzy search and change directory starting at the current directory.

requires: [fzf, fd]


## cd_.cmd

    > cd_ [directory]

Change to %USERPROFILE% and optionally [directory]


## cd-.cmd
  
  > cd- [count = 1] [directory]

Go up 1 or optionally [count] directories. cd to [directory] if given. [count] is not optional if using [directory]


## frf.cmd

Find recent files. Defaults to 1 day and a max-depth of 2. Example durations: 2weeks, 20min, 3d, 1month, 4days, 30sec


    > frf [duration = 1d] [depth = 2]

requires: [fd]


## duck.rb

Open duckduckgo.com in your default browser with the search terms.

    > duck some search terms

requires: [Ruby]

## google.rb

    > google some search terms

Open google.com in your default browser with the search terms.

requires: [Ruby]

---

vim:sw=4:ts=4:et:

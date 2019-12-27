# scripts for Windows cmd.exe

Scripts and shortcuts mostly for working in Windows cmd.exe.

### Process

**ps.cmd**

    interactive process viewer/killer. Requires `fzf`.



### Navigation

**cd__** [directory]

    Change directory to %USERPROFILE%, and optionally a directory.

**cd- [N]**

    Go back 1 directory. With N, go back N levels.

**fcd**

    Fuzzy cd. Opens interactive directory list in the current directory. Type to filter. Use <kbd>up</kbd>/<kbd>down</kbd> to select.  Press  <kbd>ENTER</kbd> to go to the selected directory. Requires `fzf`


[1] https://github.com/junegunn/fzf

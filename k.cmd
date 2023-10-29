@echo off
setlocal

where /q fzf.exe
if %errorlevel% neq 0 (
	echo Could not find fzf.exe. https://github.com/junegunn/fzf
	exit /b
)
where /q keg.exe
if %errorlevel% neq 0 (
	echo Could not find keg.exe. https://github.com/rwxrob/keg
	exit /b
)
where /q gum.exe
if %errorlevel% neq 0 (
	echo Could not find gum.exe. https://github.com/charmbracelet/gum
	exit /b
)
where /q cat
if %errorlevel% neq 0 (
	echo Could not find cat.
	echo I recommend busybox on Windows. https://www.busybox.net/
	exit /b
)

if not exist keg (
	echo Did not find 'keg' file in this directory.
	echo run `keg init` to make this a keg directory.
	exit /b
)



set SORT=busybox sort
set FZF_DEFAULT_OPTS=--reverse
set FZF_DEFAULT_COMMAND=%sort% -n dex/nodes.tsv
set HI=[37m

rem --preview "cat {1}/readme.md" ^
rem --preview "less -R {1}\README.md" ^
rem --preview "mdcat {1}\README.md|less -r" ^
rem --preview "glow {1}/readme.md" ^
rem --preview "bat -p -l markdown --color always {1}/readme.md" ^
rem --bind "ctrl-u:execute(git pull & pause)+reload(%FZF_DEFAULT_COMMAND%)" ^
rem --preview "keg view {1}" ^

fzf --ansi ^
--preview "cat {1}/readme.md |gum format" ^
--exact ^
--no-mouse ^
--no-sort ^
--delimiter="\t" ^
--color preview-bg:#202020 ^
--header-first --header="[%CD%] ESC to exit." ^
--preview-window "down,70%%,wrap" ^
--header "sort: ctrl-%HI%i[0mndex, ctrl-title, ctrl-recent | ctrl-n: new" ^
--bind "home:top" --bind "end:last" ^
--bind "alt-j:down" --bind "alt-k:up" ^
--bind "ctrl-c:execute(cat {1}/readme.md |clip)" ^
--bind "ctrl-n:execute(keg create)+reload(%FZF_DEFAULT_COMMAND%)" ^
--bind "enter:execute(%EDITOR% -R {1}/README.md)+reload(%FZF_DEFAULT_COMMAND%)" ^
--bind "ctrl-e:execute(keg edit {1})+reload(%FZF_DEFAULT_COMMAND%)" ^
--bind "enter:execute(keg edit {1})+reload(%FZF_DEFAULT_COMMAND%)" ^
--bind "del:execute(keg delete {1})+reload(%FZF_DEFAULT_COMMAND%)" ^
--bind "ctrl-i:reload(%sort% -n -k1 dex\nodes.tsv)" ^
--bind "ctrl-r:reload(%sort% -rk2 dex\nodes.tsv)+pos(1)" ^
--bind "ctrl-t:reload(%sort% -k4 dex\nodes.tsv)" ^
--bind "ctrl-h:preview:type %userprofile%\scripts\k.hlp"


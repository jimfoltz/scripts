@echo off
setlocal
set HELP=

if not exist keg (
	if [%1]==[-i] (
		call rkeg init
	) else (
		echo No keg file found. Use 'k -i' to init.
		exit /b
	)
)



set SORT=bb sort
set FZF_DEFAULT_OPTS=--reverse
set FZF_DEFAULT_COMMAND=bb sort -rk2 dex/nodes.tsv

rem --preview "cat {1}/readme.md" ^
rem --preview "keg view {1}" ^
rem --preview "less -R {1}\README.md" ^
rem --preview "mdcat {1}\README.md|less -r" ^
rem --preview "glow {1}/readme.md" ^
rem --preview "bat -p -l markdown --color always {1}/readme.md" ^
rem --bind "ctrl-u:execute(git pull & pause)+reload(%FZF_DEFAULT_COMMAND%)" ^

fzf --ansi ^
--preview "cat {1}/readme.md |gum format" ^
--exact ^
--no-sort ^
--delimiter="\t" ^
--color preview-bg:#202020 ^
--header-first --header="[%CD%] ESC to exit." ^
--preview-window "down,70%%,wrap" ^
--header "sort: ctrl-[36mi[0mndex, ctrl-title, ctrl-date" ^
--bind "home:top" --bind "end:last" ^
--bind "alt-j:down" --bind "alt-k:up" ^
--bind "ctrl-c:execute(cat {1}/readme.md |clip)" ^
--bind "ctrl-n:execute(keg create)+reload(%FZF_DEFAULT_COMMAND%)" ^
--bind "enter:execute(nvim -R {1}/README.md)+reload(%FZF_DEFAULT_COMMAND%)" ^
--bind "ctrl-e:execute(keg edit {1})+reload(%FZF_DEFAULT_COMMAND%)" ^
--bind "enter:execute(keg edit {1})+reload(%FZF_DEFAULT_COMMAND%)" ^
--bind "del:execute(keg delete {1})+reload(%FZF_DEFAULT_COMMAND%)" ^
--bind "ctrl-i:reload(%sort% -n -k1 dex\nodes.tsv)" ^
--bind "ctrl-d:reload(bb sort -rk2 dex\nodes.tsv)" ^
--bind "ctrl-t:reload(bb sort -k4 dex\nodes.tsv)"

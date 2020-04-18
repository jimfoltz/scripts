Red [
	Title: ""
]

; vim: ts=4:sw=4:expandtab

d: func [w] [
	print rejoin [w ": " mold get :w lf]
]

args: system/options/args

if opt-d: remove find args "-d" [
	?? args
	path-exts: get-env 'pathext
	d 'path-exts
	print append/dup "" "-" 20
]

opt-q:  take find args "-q" ; quote output
opt-s:  remove find args "-s" ; search
opt-cd: remove find args "-cd"
opt-e:  remove find args "-e"

prog: take args
; ?? prog

; ?? args
path-len: length? path-var: get-env 'path
paths:    unique split path-var ";"
;paths: split path-var ";"
remove-each v paths [ empty? v ]
;append paths "C:\Windows\Sysnative"
insert paths "."

if exists? %/c/windows/sysnative [
	foreach p paths [
		replace p "C:\Windows\System32" "C:\Windows\Sysnative"
	]
]

exts: split get-env 'pathext ";"
forall exts [lowercase first exts]
if opt-d [ ?? exts ]

if none? prog [
	prin lf
	;print ["path-length:" path-len]
	paths: next paths ; skip .
	foreach p paths [print p]
	quit
]

is-built-in?: func [
	prog [string!]
	return: [logic!]
	/local out cmds line cmd
] [
	out: copy {}
	cmds: copy []
	call/output "help" out
	foreach line split out lf [
		cmd: first split line space
		unless empty? cmd [ append cmds cmd ]
	]
	if opt-d [ ?? cmds ]
	;print ["select" cmds prog lf]
	if find cmds prog [ return true ]
]

if is-built-in? prog [
	print ["built-in: " prog]
]

; -s search
;if opt-s [
;	foreach path paths [
;		if opt-d [print [] ?? path]
;		if #"\" <> last path [ append path "\" ]
;		files: attempt [read to file! path]
;		if files [
;			foreach file files [
;			if opt-d [ ?? file ]
;				suf: suffix? file
;				if opt-d [ ?? suf ]
;				if suf [
;					r: select exts to-string suf
;					if opt-d [ ?? r ]
;					if r [
;						if f: find file prog [
;							if opt-d [ ?? f ]
;							print rejoin [path file]
;							;append found rejoin [path file]
;						]
;					]
;				]
;			]
;		]
;	]
;]


if opt-s [
	foreach path paths [
		if opt-d [print [] ?? path]
		if #"\" <> last path [ append path "\" ]
		files: attempt [read to file! path]
		if files [
			foreach file files [
                if opt-d [ ?? file ]
                if f: find file prog [
                    if opt-d [ ?? f ]
                    print rejoin [path file]
                ]
			]
		]
	]
]

found: copy []
foreach path paths [
	if #"\" <> last path [ append path "\"]
	if opt-d [print [] ?? path]
	foreach ext exts [
		exe: rejoin [path prog ext]
		if opt-d [ ?? exe ]
		f: to-file exe 
		if opt-d [?? f]
		if exists? f [
			if opt-d [prin "==> Found: "]
			print exe
			append found exe
		]
	]
]
if opt-d [?? found]

if opt-cd [
	if 1 <= length? found [
		sp: split-path to-red-file found/1
		path: to-local-file first split-path to-red-file first found
		; cmd: rejoin [{cmd /k "prompt=$P$A$G & cd "} path {"}]
		cmd: rejoin [{start "" /d "} path {"}]
		call/shell cmd
		quit
	]
]

if opt-e [
	call rejoin ["gvim " found/1]
]


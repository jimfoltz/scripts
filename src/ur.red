Red [
    title: "Use Red version"
]

; #include %json.red

fetch-page: does [
    read https://static.red-lang.org/download.html
]

fetch-latest-name: function [] [
    page: fetch-page
    pos: find page "Automated builds"
    pos: find/tail pos {.exe">}
    unless pos [
        print "could not find exe in html page."
        quit
    ]
    copy/part pos find/tail pos ".exe"
]

current-exe: function [] [
]

print-commits: function [ curr_v new_v ] [
]

have?: function [exe-name] [
    target: to-file rejoin [get-env 'userprofile "/bin/red/" exe-name]
    either exists? target [ true ] [ false ]
]

current?: function [exe-name [string!]] [
    r: find read to-file rejoin [get-env 'userprofile "/bin/red.cmd"] exe-name
    either r [ true ] [ false ]
]

fetch-exe: function [exe-name [string!]] [
    target: to-file rejoin [get-env 'userprofile "/bin/red/" exe-name]

    either exists? target [
        print ["file exists:" to-local-file target]
    ] [
        print ["writing" to-local-file target]
        write/binary target read/binary https://static.red-lang.org/dl/auto/win/red-latest.exe
    ]
]

update-cmd: function [exe-name [string!]] [
    cmd: rejoin ["@%~dp0red\" exe-name space "%*" lf]
    cmd: rejoin [{@if "%1" == "-V" echo using [ } exe-name { ]} lf "@%~dp0red\" exe-name space "%*" lf]
    print ["Updating red.cmd"]
    write to-file rejoin [get-env 'userprofile "/bin/red.cmd"] cmd
]

hash-of: function [exe] [
    s: copy/part next pos: find/last exe "-" find pos ".exe"
    third split exe charset "-."
]

date-of: function [exe] [
    d: copy/part pos: next find exe "-" find pos "-"
    day: take/part d 2
    mon: take/part d 3
    yr: 2000 + to-integer d
    months: ["jan" "feb" "mar" "apr" "may" "jun" "jul" "aug" "sep" "oct" "nov" "dec"]
    mon-no: index? find months mon
    ;load rejoin [yr "-" mon "-" day]
    rejoin [yr "-" mon-no "-" day]
]

list-commit-msgs: func [exe] [
    cmd: second split read to-file rejoin [get-env 'userprofile "/bin/red.cmd"] lf
    cur-exe: copy/part pos: find cmd "red-" find/tail pos "exe"
    d: rejoin [date-of cur-exe]; "T00:00"]
    url: rejoin [https://api.github.com/repos/red/red/commits?since= d]
    dat: json/decode read url;rejoin [https://api.github.com/repos/red/red/commits?since= d]
    foreach itm dat [
        print ["  *" first split itm/commit/message lf]
    ]
]

usage: does [
    print {Usage:

    1. Check if new download is available.
    2. Offer to install it
    ^--l^-download latest, update red.cmd
    }
]

print [{ur - "Use Red"} lf]
args: system/options/args

sub-cmd-ls: take find/case args "ls"
opt-check-only: take find/case args "-c"
opt-install: take find/case args "-i"

; accepts:
;   version: 064
;   git commit hash: 3b0a5
;   date-str: "24nov18"


if sub-cmd-ls [
    files: read to-red-file rejoin [get-env 'userprofile "/bin/red/"]
    foreach file files [
        print file
    ]
    quit
]
vers: take args
exe: fetch-latest-name

if opt-check-only [
    ?? exe
    unless have? exe [print ["New version available!" lf]]
    print ["have :" have? exe]
    print ["using:" current? exe]
    quit
]

; no version given, check for latest and install
if none? vers [
    either all [ have? exe current? exe ] [
        print ["You are already using the most recent Red."]
    ] [
        ; install and use latest version
        print ["New version available!" exe lf]
        list-commit-msgs exe
        either opt-install [
            fetch-exe exe
            update-cmd exe
        ] [
            print [lf {Re-run using the "-i" option to install.}]
        ]
    ]
    quit
]

either have? exe [
    print "Switch to exsiting version here."
    print [have? exe "exists."]
] [
    print ["Can not get version: " vers]
    quit
]


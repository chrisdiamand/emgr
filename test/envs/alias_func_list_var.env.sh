export TEST1="hello world!"

alias myalias='ls -l'

function myfunction() {
    echo "$TEST1"
}

MYLIST=(
    elem1
    elem2
)

export mypath="/usr/local/added_by_env:$mypath"

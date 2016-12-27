export TEST1="hello world!"

alias myalias='ls -l'

function myfunction() {
    echo "$TEST1"
}

MYLIST=(
    elem1
    elem2
)

myappendarray=(
    add_to_the_start
    ${myappendarray}
    added_by_env
    "something with spaces"
)

export mypath="/usr/local/added_by_env:$mypath"

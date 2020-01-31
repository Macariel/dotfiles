# Creates a directory and is going into it
mkcd() {
    mkdir $1; cd $1
}

# swaps the content of two files
function swap() {
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE && mv "$2" "$1" && mv $TMPFILE $2
}

# outputs the content of every file which is found by the given path regex
# Difference to 'cat' is, that it puts a whitespace between the file contents
function cat_() {
    for f in $(eval "find $1"); do (cat "${f}"; echo); done
}

# Calculate the given expression in bc
function c() {
    echo $@ | bc
}

# List directory after cd
function chpwd() {
    emulate -LR zsh
    ll
}

# Print the weather forecast in the terminal
function weather() {
  curl "v2.wttr.in/$1"
}

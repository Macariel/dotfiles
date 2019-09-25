alias apt-full="sudo apt update;sudo apt upgrade;sudo apt dist-upgrade -y;sudo apt autoremove -y;"
alias loadNeo="setxkbmap de neo"
alias loadDe="setxkbmap de"
alias lsold="command ls -rtlh *(D.Om[1,10])"
alias cwd="pwd | clipcopy"
alias dc="docker-compose"
alias dce="docker-compose exec"
alias dclog="docker-compose logs --tail 50 -f"
alias gw="./gradlew"
eval $(thefuck --alias) # insert the 'fuck' alias

# Extra programs
alias ls="exa"
alias la="exa -la"
alias fd="fdfind"

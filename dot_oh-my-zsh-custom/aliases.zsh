alias asdf="setxkbmap de neo"
alias uiae="setxkbmap de"
alias lsold="command ls -rtlh *(D.Om[1,10])"
alias cwd="pwd | clipcopy"
alias dc="sudo docker-compose"
alias dce="sudo docker-compose exec"
alias dclog="sudo docker-compose logs --tail 50 -f"
alias d="sudo docker"
alias gw="./gradlew"
alias gwb="./gradlew bootstrap"
alias gwcb="./gradlew clean bootstrap"
eval $(thefuck --alias) # insert the 'fuck' alias

alias tg="terragrunt"

# Extra programs
alias ls="exa"
alias la="exa -la"

# CQSE it
alias gcli="/home/pawelka/Workspace/cqse-it/cloud-config/gcli"

# QtCreator setup
alias qt_export="export QTC_TS_DOCKER_PARAMS=\"-e DISPLAY --net=host --device=/dev/dri --volume=/home/pawelka/.Xauthority:/root/.Xauthority\""

# Auto-type replacement
alias tcb='xdotool sleep 2 type --clearmodifiers "`xclip -o -selection clipboard`"'

# Merge Checks
alias merge-java-check="./gradlew bootstrap > /dev/null; cd engine > /dev/null; ../gradlew compileTestJava; cd .. > /dev/null"
alias merge-ts-check="./gradlew bootstrap > /dev/null; cd engine/com.teamscale.ui > /dev/null; yarn run check-and-lint; cd - > /dev/null"

# KDE
alias restart-plasma="killall plasmashell && kstart5 plasmashell"

# Teamscale
alias ts-run="python /home/pawelka/Workspace/teamscale-run-helper/teamscale_run.py"

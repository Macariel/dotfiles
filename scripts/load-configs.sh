root_dir="$( cd "$(dirname "$0")"; cd ..; pwd -P )"

# setup guake
guake --restore-preferences="$root_dir/configs/guake.conf"

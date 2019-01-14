# Usage:
#	touch_files.sh dry_run git_directory
# TODO: adapt to x input directories 

# The script touches files returned in git diff of upstream master and remote branch

function get_modified_files() {
	git --git-dir=$2/.git --work-tree=$2 diff upstream/master origin/$1 --name-only
}

function touch_files() {
	echo "Touched: "

	for file in "${array[@]}"
	do
		echo "$1/$file"
		touch "$1/$file"
	done
}

dry_run=$1
branch_name=$(git rev-parse --abbrev-ref HEAD)
git_directory=$2

FILES=$(get_modified_files $branch_name $git_directory)
IFS=$'\n' read -rd '' -a array <<<"$FILES"

printf "List of files:\n$FILES\n"

if [ $1 == '0' ]; then
	printf "\n\nAbout to update the last modified dates:\n"
	touch_files $git_directory
fi

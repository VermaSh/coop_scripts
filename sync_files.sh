# sync_workspace 'update' '' ''
# Use cases
#	- Want to do a dry run
#	- Want to do update only
#	- Want to change source and destination directories

#TODO:
#	call file from bash_aliases with appropriate arguments
#	use "-" instead of argument numbers

# ./syncFiles.sh 'n' '' 'spec' $OMR_WORKSPACE $REMOTE_COMPILE_DIR
# syncFiles.sh 'n' 'u' '' $OMR_WORKSPACE $REMOTE_COMPILE_DIR/omr
# syncFiles.sh 'n' 'u' '' $OPENJ9_WORKSPACE $REMOTE_COMPILE_DIR

machine="machine to ssh into"

mode='pushed'
options="-ravz"
if [ ! -z "$2" ] && [ "$2" = "u" ]; then
	options=$options"u"
	mode='updated'
fi
options=$options$1" --recursive --progress --prune-empty-dirs"

filters="--include=*/ --include=*.cpp --include=*.hpp \
--include=*.c --include=*.h"
extensions=".hpp, .cpp, .c, .h"
if [ ! -z "$3" ]; then
	filters=$filters" --include=*.$3"
	extensions=$extensions", .$3"
fi
filters=$filters' '$extension" --exclude=* --exclude=.*"

if [ ! -z "$6" ]; then
	filters=$filters" --exclude=$6"
fi

source=$4
destination=$5

printf "Only extensions $extensions will be $mode. \nSource      \
: $source\nDestination : $destination\n"

echo 'Filters     : '$filters
echo 'Options     : '$options

rsync $options "--exclude=.*" $source $machine:$destination
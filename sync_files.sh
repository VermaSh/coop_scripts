# sync_workspace 'update' '' ''
# Use cases
#	- Want to do a dry run
#	- Want to do update only
#	- Want to change source and destination directories

# ./syncFiles.sh 'n' '' 'spec' $OMR_WORKSPACE $REMOTE_COMPILE_DIR
# syncFiles.sh 'n' 'u' '' $OMR_WORKSPACE $REMOTE_COMPILE_DIR/omr
# syncFiles.sh 'n' 'u' '' $OPENJ9_WORKSPACE $REMOTE_COMPILE_DIR

# $1 activate dry run
# $2 toggle between update or overwrite
# $3 append extra extensions to be included
# $4 source directory
# $5 destination directory

if [ ! -z "$4" ] || [ ! -z "$5" ]; then
	echo "Please provide a valid source and destination directory"
	exit 1
fi

source=$4
destination=$5

machine= # machine to ssh into

mode='pushed'
options=-ravz

if [ ! -z "$2" ] && [ "$2" = "u" ]; then
	options=$options"u"
	mode='updated'
fi

options=$options$1 --progress --prune-empty-dirs

extensions='.hpp, .cpp, .c, .h'
if [ ! -z "$3" ]; then
	extensions=$extensions", .$3"
fi

printf "Only extensions $extensions will be $mode. \nSource      \
: $source\nDestination : $destination\n"

rsync $options --include='*.'{cpp,hpp,c,h,$3} \
	--exclude='*' \

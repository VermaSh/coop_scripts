export RESULTSDIR="$CURRENT_SOURCE/bin/ABBS/results";

# Instructions
# 	$1: iteration count
# 	$2: extra java options 
#	$3: driver file location
#	$4: environt file location

iterationCount=$1
javaOptions=$2

# TODO: Maybe hardcode these if they are the same for all tests
driverFile=$3
envFile=$4

for i in $(seq 1 $iterationCount);
do
	current_date=$(date '+%Y_%m_%d__%H%M%S')
	logFile=$i'_ABBS_result_'$current_date'.txt' # Absolute path to the log file
	echo 'Job #: '$i' logs: '$logFile

	perl "script location" \
		-nokill -mode=600 \
		-driver=$driverFile \
		-envFile=$envFile \
		-javahome=$CURRENT_JAVA_HOME \
		-javaOpts='-verbose:gc -Xnocompressedrefs'$javaOptions -mxCap=256 &> $logFile

done


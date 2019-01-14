# TODO:
# 	- change the variables to input
#	- maybe update bashrc with the new file path
# 	- update the global variables with the new path


buildId=$1
platform=''
javaRelease=''

vmtank='source server'

outputDirectory='/team/shubhamv/sources'
outputFileName=$platform'_'$buildId'.zip'
downloadTarget=$outputDirectory'/'$outputFileName

wgetURL=$vmtank$javaRelease'/'$platform'/'$buildId'/'$platform'.zip'
unzipTarget=$outputDirectory'/'$buildId

echo $wgetURL
echo $unzipTarget

wget -O $downloadTarget $wgetURL

if [ $? -eq 0 ]
then	
	if [ ! -d $unzipTarget ] 
	then
		echo "Going to make directory $unzipTarget"
		mkdir $unzipTarget
	fi

	unzip -q $downloadTarget -d $unzipTarget
	if [ $? -eq 0 ]
	then
		echo "Source files have been extracted to: $unzipTarget"
	else
		echo "Couldn't successfully extract files" 
	fi

	
else
	echo 'Ran into trouble getting the zip file'
fi

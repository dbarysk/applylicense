#!/bin/sh
##########################################################################
#
# Author: Dmytro Baryskyy (dbarysk@gmail.com)
#
##########################################################################

LICENSE_HEADER=$1
FILE_PATTERN=$2

# Checking input parameters
if [ -z "$LICENSE_HEADER" ] || [ -z "$FILE_PATTERN" ]
then
    echo "Description: Script appends license header to text files on the top."
    echo "First parameter is a license header text file. Second one is file name pattern that will be used to look for the files."
    echo "Usage: $0 <header file> <file name pattern>"
    echo "         Example: $0 header.txt *.java"
    exit 1
fi

# Looking for files
FILES=`find $(pwd) -name "$FILE_PATTERN"`

echo "Applying license header to files: "
for file_orig in $FILES # or whatever other pattern...
do

  if ! grep -q Copyright $file_orig
  then
     # Adding copyright header to the top of the file.
     echo "Updating file $file_orig"
     cat $LICENSE_HEADER > $file_orig.new && printf "\n\n" >> $file_orig.new && cat $file_orig >> $file_orig.new && mv $file_orig.new $file_orig
  else
     # Looks like file already has "Copyright" notice so we skipped it.
     # Probably need to do more clever check
  	 echo Skipped $file_orig
  fi
done

echo "Done"
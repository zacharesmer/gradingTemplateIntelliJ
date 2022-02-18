#!/bin/bash
submissionDir="Submissions"
assignmentDir="allAssignments"
filename="Main.java"


# if it doesn't exist yet, make the directory for done files
[[ -d "$submissionDir" ]] || mkdir "$submissionDir";
# cd "$submissionDir" || exit

# unzip the big file with all the submissions into a directory
unzip "$1" -d "$submissionDir/$assignmentDir"
# move into that directory
cd "$submissionDir/$assignmentDir" || exit

# rename the folders and zip files to something more manageable
for f in *; do
  newName="${f%%_attempt*}"
  newName="${newName##*_}"
  newName="${newName:1}"
  newName="${newName//[0-9]/}"
  if [[ "${f##*.}" == "zip" ]]; then
    newName="$newName.zip"
  elif [[ "${f##*.}" == "txt" ]]; then
    newName="$newName.txt"
  elif [[ -d "$f" ]]; then
    # nop
    newName="$newName"
  else
    continue;
  fi
  mv "$f" "$newName"
done

# handle cases where a student submitted a zip file
for f in *.zip; do
   # make a folder named the same thing but without the .zip
   newDir="${f%.*}"
   mkdir "$newDir"
   # unzip their work into it
   unzip "$f" -d "$newDir"
   # match the comments file and rename it to comments.txt in the student's directory
   mv "${f%.*}".txt "$newDir"/comments.txt
done

# # handle cases where a student submitted a .java file
# for f in *.java; do
#    # make a folder named the same thing but without the .java
#    newDir="${f%.*}"
#    mkdir "$newDir"
#    # move the java file into that dir
#    mv "${f}" "$newDir/""$filename"
#    # move the comments file into that dir
#    mv "${f%_*}.txt" "$newDir/comments.txt"
# done


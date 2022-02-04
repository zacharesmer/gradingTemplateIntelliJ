#!/bin/bash
submissionDir="Submissions"
assignmentDir="allAssignments"
filename="Main.java"

# if it doesn't exist yet, make the directory for done files
[[ ! -d "$submissionDir" ]] && mkdir "$submissionDir";

# unzip the big file with all the submissions into a directory
unzip "$1" -d "$submissionDir/$assignmentDir"
# move into that directory
cd "$submissionDir/$assignmentDir" || exit

# handle cases where a student submitted a zip file
for f in *.zip; do
   # make a folder named the same thing but without the .zip
   newDir="${f%.*}"
   mkdir "$newDir"
   # unzip their work into it
   unzip "$f" -d "$newDir"
   # match the comments file (assumption: students will not submit something with _ in the title)
   mv "${f%_*}".txt "$newDir"/comments.txt
done

# handle cases where a student submitted a .java file
for f in *.java; do
   # make a folder named the same thing but without the .java
   newDir="${f%.*}"
   mkdir "$newDir"
   # move the java file into that dir
   mv "${f}" "$newDir/""$filename"
   # move the comments file into that dir
   mv "${f%_*}.txt" "$newDir/comments.txt"
done

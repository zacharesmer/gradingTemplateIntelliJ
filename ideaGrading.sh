#!/bin/bash

filename="Main.java"
doneDir="Submissions/doneGrading/"
gradingDir="grading/src/main/java/com/example/"

# if it doesn't exist yet, make the directory for done files
[[ ! -d "$doneDir" ]] && mkdir "$doneDir";

for d in Submissions/allAssignments/*/; do
  # print which student's work is being graded
  echo "grading " "$d";
  # print a message if the student didn't submit a correctly named file
  [[ $(find "$d" -name $filename -type f) ]] || {
    echo "could not find file $filename in $d"
    continue;
  }
  # otherwise find the correctly named file
  f=$(find "$d" -name "$filename" -type f);
  # copy the file into the idea project
  cp "$f" "$gradingDir";
  # then move it into the done folder
  mv "$d" "$doneDir";
  # wait for the user to enter next or exit
  echo "type next (or n) to go to the next student or exit to stop grading"
  while read doNext;  do 
    if [[ "$doNext" == "next" ]]; then
      break;
    fi
    if [[ "$doNext" == "n" ]]; then
      break;
    fi
    if [[ "$doNext" == "exit" ]]; then
      break 2;
    fi
    echo "type next to go to the next student or exit to stop grading"
  done

done

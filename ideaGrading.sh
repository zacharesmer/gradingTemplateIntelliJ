#!/bin/bash

filename="Main.java"
submissionDir="Submissions"
startDir="$submissionDir/allAssignments/"
doneDir="$submissionDir/doneGrading/"
gradingDir="grading/src/main/java/com/example/"

prompt="type next (n) to go to the next student, exit (q) to stop grading, or search (s) to search for a student's last name"
divider="~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

# if it doesn't exist yet, make the directory for done files
[[ ! -d "$doneDir" ]] && mkdir "$doneDir";

show_submission(){
  d=$1;
  # print which student's work is being graded
  echo "$divider"
  echo "grading " "$d";
  echo "$divider"
  # print the comments file
  cat "$d"comments.txt
  # print a message if the student didn't submit a correctly named file
  [[ $(find "$d" -name $filename -type f) ]] || {
    echo "could not find file $filename in $d"
    return;
  }
  # otherwise find the correctly named file
  f=$(find "$d" -name "$filename" -type f);
  # copy the file into the idea project
  cp "$f" "$gradingDir";
}

search_name(){
  # enter a search string
  read searchString;
  # echo "You searched for $searchString"
  # find all folders matching that student's name, aka *"$name"*
  # and store them in an array
  IFS=$'\n' # this is a questionable hack to make an array from the output of find
  paths=($(find "$submissionDir" -maxdepth 2 -name "*$searchString*" -type d))
  unset IFS
  printf "\n"
  for i in "${!paths[@]}"; do
    # show all found files with their array index to choose from
    echo "$i" "${paths[i]##*/}";
  done;
  # if no files found print a message
  if [[ 0 -eq ${#paths[@]} ]]; then
    echo "No matches found."
    return
  fi
  printf "\n%s\n" "q Back to main menu"
  while read whichFile; do
    if [[ "$whichFile" == "q" ]]; then
      break
    # check if choice is within bounds of the array and show that file
    elif [[ "$whichFile" -lt ${#paths[@]} ]]; then
      show_submission "${paths[whichFile]}/"
      break
    else
      echo "Enter a number to pick a student or q to return to the main menu"
    fi
  done
}

for d in "$startDir"*/; do
  show_submission "$d";
  # move that submission into the done folder
  mv "$d" "$doneDir";

  # wait for the user to enter next, exit, or search for a student
  echo "$prompt"
  while read doNext;  do 
    if [[ "$doNext" == "next" || "$doNext" == "n" ]]; then
      break;
    fi
    if [[ "$doNext" == "exit" || "$doNext" == "q" ]]; then
      break 2;
    fi
    if [[ "$doNext" == "search" || "$doNext" == "s" ]]; then
      search_name
    fi
    echo "$prompt"
  done

done

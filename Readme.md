# Readme
This tool takes a zip file from Blackboard, extracts each student's submitted work, and moves the relevant files one by one into a  project open in IntelliJ IDEA (or likely another IDE, but that is untested). There, tests and debugging can be performed. This is an example/template version, with student and assignment details omitted. It has been tested on Ubuntu and Mac OS.

To use with an actual student project:

- Download this template.
- Write tests for the student project and put them in the test directory.
- (optional) Distribute a template for the students with the correct dependencies in build.gradle, and a consistent package structure
- Ensure the students submit the part of the project that you will be grading in consistently named files with the correct package declaration. In this example, the script is looking for Main.java and moving it into the com.example package for grading. Edit these variables with the actual package name and file name(s) at the top of `extractSubmissions.sh` and `ideaGrading.sh` respectively.
- Run `./extractSubmissions "~/path/to/blackboard/download.zip"` to extract the blackboard zip file.
- Open the `grading` directory in IntelliJ IDEA as a project. 
- Run `./ideaGrading.sh` . This opens the students' submissions one by one in the open IDEA project. There you can run tests and debug the code. 

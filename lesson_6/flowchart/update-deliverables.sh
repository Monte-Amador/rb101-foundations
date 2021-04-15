#!/bin/bash

# REFORMAT IFS (INTERNAL FIELD SEPARATOR)
IFS=$'\n\t'

if [[ -d "$(pwd)/02_working_files" ]]; then
	projectDir="$(pwd)"
	deliverablesDir="05_deliverables";
	broken=$(find "${projectDir}/${deliverablesDir}/final_working_files" -type l ! -exec test -e {} \; -print)
	workingDir="${projectDir}/02_working_files";

	# Test for Broken Links
	if [[ -n "${broken}" ]]; then
		echo "Step 1: We have broken links."
		# Create a broken-link text file
		while read -r link; do
			echo "${link//.\//}" >> "${projectDir}/broken-links.txt"; done <<< "${broken}"
		# Create a relink executable to proof
		while read -r location; do 
				filePath=$(mdfind "${location##*/}" -onlyin "${projectDir}")
				echo "filepath: ${filePath}"
				if [[ -n "${filePath}" ]]; then
					echo "## Proposed Found Link(s)" >> "${projectDir}/relink"
					printf "\n" >> "${projectDir}/relink"
					
					while read -r linkEntry; do
						echo "ln -sfn ${linkEntry##*>\ }" >> "${projectDir}/relink"
					done <<< "${filePath}"
					
					printf "\n\n" >> "${projectDir}/relink"
					echo "## Proposed Target Location(s)" >> "${projectDir}/relink"
					echo "${location}" >> "${projectDir}/relink";
			
				else
					echo "No files matching the broken link file within the project directory, use the file 'broken-links.txt' to find the missing components manually."
				fi
			 
		done < "${projectDir}/broken-links.txt"
	else 
		echo "Step 1: All project symlinks are working."
	fi

	modFile="$(ls -ltr "${workingDir}" | grep '^-')";
	# Test if modFile exists or exit
	if [[ $? == 1 ]]; then
		echo "No file available found, double check the directory's contents and/or check for broken links, will exit now";
		exit 1;
	else
		modFile="$(ls -ltr "${workingDir}" | grep '^-' | tail -1)";
		modFile="${modFile##*:[0-9][0-9]\ }";
		if [[ -f "${workingDir%/*}/05_deliverables/final_working_files/${modFile%.*}-final.${modFile##*.}" ]]; then
			echo "File already exists, you should either Save As or leave alone. Exiting now"
			exit 1;
		else
			echo "Step 2: Adding symlinks to the Delivarbles/final_working_files directory."
			ln -s "${workingDir}/${modFile}" "${workingDir%/*}/05_deliverables/final_working_files/${modFile}";	
			# ln -s "${workingDir}/${modFile}" "${workingDir%/*}/05_deliverables/final_working_files/${modFile%.*}-final.${modFile##*.}";	
		fi

	fi
fi









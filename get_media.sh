#!/bin/bash

#--------------------------------------
#Print error message and
#display propper command usage
#
# Arguments:
#   message
# Returns:
#   None
#--------------------------------------

print_error_message() {
	printf "\n****************************************\n"
	printf "$1\n"
	printf "CORRECT USAGE: ./get_media.sh"
	printf "\n****************************************\n\n"
}

#--------------------------------------
#Get volume name to extract footage from
#Validate that the user selected volume exists
#Get photos and/or footage from volume
#
# Arguments:
#   command_options -[pf]
# Returns:
#   None
#--------------------------------------

execute_media_extraction() {
	local i=0; local volumes; local vol; local vol_nm
	printf "\n****************************************"
	printf "\nSELECT WHICH VOLUME TO GET MEDIA FROM: \n"
	while read line; do volumes[ $i ]="$line"; (( i++ )); done < <(ls /Volumes/)
	i=1; for elm in "${volumes[@]}"; do printf "\n $i: $elm"; (( i++ )); done
	printf "\n\nSELECT VOLUME BY NUMBER (1, 2, ...): " ; read vol; (( i-- ))
	while [ $vol -lt 1 ] || [ $vol -gt $i ] ; do
		printf "INVALID SELECTION! RE-SELECT VOLUME: " ; read vol
	done; (( vol-- )); vol_nm=${volumes[ $vol ]}
	printf "****************************************\n\n"
	extract_media "$vol_nm"
}

#--------------------------------------
#Automatically extracts media from selected
#volume
#
# Arguments:
#   volume_name
# Returns:
#   None
#--------------------------------------

extract_media() {
	local vid_formats="mov|MOV|mp4|MP4"
	local pic_formats="jpg|JPG|jpeg|JPEG|png|PNG"
	create_directories
	copy_media_to_directory "$1" "Media" "Pics" $pic_formats
	copy_media_to_directory "$1" "Media" "Videos" $vid_formats
	prompt_user_about_deleting_media "$1" "Pics" $pic_formats
	prompt_user_about_deleting_media "$1" "Videos" $vid_formats
}

#--------------------------------------
#Creates directory structure
#
# Arguments:
#   None
# Returns:
#   None
#--------------------------------------

create_directories() {
	local stamp=$(date "+%m-%d-%y")
	create_directory "Media"
	create_directory "Media/$stamp"
	create_directory "Media/$stamp/Pics"
	create_directory "Media/$stamp/Videos"
}

#--------------------------------------
#Creates a directory in home directory
#
# Arguments:
#   directory
# Returns:
#   None
#--------------------------------------

create_directory() {
	if [ ! -d "$HOME/$1" ]
	then mkdir $HOME/"$1"
	fi
}

#--------------------------------------
#Copy all media to new user created directory
#
# Arguments:
#   volume_name, media_directory, sub_directory, file_extension_filters
# Returns:
#   None
#--------------------------------------

copy_media_to_directory() {
	local ts=$(date "+%m-%d-%y")
	printf "COPYING $3...\n"
	find -E "/Volumes/$1" -iregex ".*\.($4)" -exec cp "{}" "$HOME/$2/$ts/$3" \;
}

#--------------------------------------
#Ask user if they want to delete
#the copied media from the volume
#they selected
#
# Arguments:
#   volume_name, media_directory, file_extension_filters
# Returns:
#   None
#--------------------------------------

prompt_user_about_deleting_media() {
	printf "\n****************************************"
	printf "\nREMOVE ALL $2 FROM VOLUME {Y or N} ?: "; read answer
	while [[ $answer != [YyNn] ]] ; do
		printf "REMOVE ALL $2 FROM VOLUME?: " ; read answer
	done
	if [[ $answer == [Yy] ]]
	then
		delete_media "$1" $2 $3
	fi
	printf "****************************************\n"
}

#--------------------------------------
#Delete media from volume
#
# Arguments:
#   volume_name, media_directory, file_extension_filters
# Returns:
#   None
#--------------------------------------

delete_media() {
	printf "REMOVING ALL $2...\n"
	find -E "/Volumes/$1" -iregex ".*\.($3)" -exec rm "{}" 2> /dev/null \;
}

#--------------------------------------
#Validate get_media command entered
#properly
#
# Arguments:
#   command_options -[pf]
# Returns:
#   None
#--------------------------------------

main() {
	if [ $# -eq 0 ];
	then execute_media_extraction
	else print_error_message "INCORRECT NUMBER OF ARGUMENTS"
	fi
}

main "$@"
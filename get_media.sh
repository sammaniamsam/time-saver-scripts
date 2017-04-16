#!/bin/bash

#--------------------------------------
#Print specific error message and
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
	print_command_arg_options
	printf "\n****************************************\n\n"
}

#--------------------------------------
#Print correct command usage
#
# Arguments:
#   None
# Returns:
#   None
#--------------------------------------

print_command_arg_options() {
	printf "pics only <command> -p\n"
	printf "footage only <command> -f\n"
	printf "pics and footage <command> -pf OR -fp"
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
	local cmd_option=$1; local i=0; local volumes; local vol; local vol_nm
	printf "\n****************************************"
	printf "\nSELECT WHICH VOLUME TO GET MEDIA FROM: \n"
	while read line; do volumes[ $i ]="$line"; (( i++ )); done < <(ls /Volumes/)
	i=1; for elm in "${volumes[@]}"; do printf "\n $i: $elm"; (( i++ )); done
	printf "\n\nSELECT VOLUME BY NUMBER (1, 2, ...): " ; read vol; (( i-- ))
	while [ $vol -lt 1 ] || [ $vol -gt $i ] ; do
		printf "INVALID SELECTION! RE-SELECT VOLUME: " ; read vol
	done; (( vol-- )); vol_nm=${volumes[ $vol ]}
	printf "****************************************\n"
	execute_command_option $cmd_option "$vol_nm"
}

#--------------------------------------
#Executes appropriate command option
#
# Arguments:
#   command_options -[pf]
# Returns:
#   None
#--------------------------------------

execute_command_option() {
	case "$1" in
		-f) extract_footage "$2" ;;
		-p) extract_pictures "$2" ;;
		-*) extract_pictures "$2"
			extract_footage "$2"
	esac
}

#--------------------------------------
#Executes appropriate footage methods
#
# Arguments:
#   volume_name
# Returns:
#   None
#--------------------------------------

extract_footage() {
	local footage_file_formats="mov|MOV|mp4|MP4"
	create_media_directory "Footage"
	create_directory_for_media "$1" "Footage" $footage_file_formats
	prompt_user_about_deleting_media "$1" "Footage" $footage_file_formats
}

#--------------------------------------
#Executes appropriate picture methods
#
# Arguments:
#   volume_name
# Returns:
#   None
#--------------------------------------

extract_pictures() {
	local pic_file_formats="jpg|JPG|jpeg|JPEG|png|PNG"
	create_media_directory "Pictures"
	create_directory_for_media "$1" "Pictures" $pic_file_formats
	prompt_user_about_deleting_media "$1" "Pictures" $pic_file_formats
}

#--------------------------------------
#Create a media directory in home directory
#
# Arguments:
#   media_directory
# Returns:
#   None
#--------------------------------------

create_media_directory() {
	if [ $(find $HOME -maxdepth 1 -name "$1" | wc -l) -eq 0 ]
	then
		mkdir $HOME/"$1"
	fi
}

#--------------------------------------
#Get user to create a directory in
#which to store their media
#
# Arguments:
#   volume_name, media_directory, file_extension_filters
# Returns:
#   None
#--------------------------------------

create_directory_for_media() {
	printf "\n****************************************"
	printf "\nSELECT NAME FOR NEW $2 DIRECTORY\n"
	local dir_nm ; printf "DIRECTORY NAME: " ; read dir_nm
	while [ $(find "$HOME/$2/" -maxdepth 1 -name "$dir_nm" | wc -l) -gt 0 ] ; do
		printf "DIRECTORY EXISTS! RE-ENTER DIRECTORY NAME: " ; read dir_nm
	done
	mkdir "$HOME/$2/$dir_nm"
	copy_media_to_user_created_directory "$1" $2 $3
	printf "****************************************\n"
}

#--------------------------------------
#Copy all media to new user created directory
#
# Arguments:
#   volume_name, media_directory, file_extension_filters
# Returns:
#   None
#--------------------------------------

copy_media_to_user_created_directory() {
	printf "COPYING $2...\n"
	find -E "/Volumes/$1" -iregex ".*\.($3)" -exec cp "{}" "$HOME/$2/$dir_nm" \;
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
#Validate get_media command options and
#invoke appropriate methods
#
# Arguments:
#   command_options -[pf]
# Returns:
#   None
#--------------------------------------

main() {
	if [ $# -eq 1 ];
	then isValidArg="^-(p|f|fp|pf){1}$"
		if [[ $1 =~ $isValidArg ]];
		then execute_media_extraction $1
		else print_error_message "INVALID ARGUMENTS"
		fi
	else print_error_message "INCORRECT NUMBER OF ARGUMENTS"
	fi
}

main "$@"
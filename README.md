# Synopsis

## The scripts in time-saver-scripts are written for Mac OSX Terminal

### get_media.sh

- Copies any photos and/or videos from an external device
- Creates **Pictures** directory and/or **Footage** directory:
  - **$HOME/Pictures**
  - **$HOME/Footage**
- Within the **Pictures** directory and/or **Footage** directory:
  - Media can be stored in custom directories you create
  - Media can be automatically stored in time stamped directories (**mm-dd-yy**)
- Deletes copied media if specified or automatically ('auto' option)

# Code Examples
Example | Explanation
----------------- | -----------------
./get_media.sh **-a** | auto
./get_media.sh **-p** | pics only
./get_media.sh **-f** | footage only
./get_media.sh **-fp** | pics and footage **-pf** OR **-fp**

##Further Explanation

- Auto (-a)
  - If not created, creates **$HOME/Pictures** and **$HOME/Footage**
  - You select a volume from which to copy media
  - Copies pics and footage to:
    - **$HOME/Pictures/mm-dd-yy**
    - **$HOME/Footage/mm-dd-yy**
  - Removes all pics and footage from your selected volume

- Pics Only or Footage Only (-p OR -f)
  - If not created, creates **$HOME/Pictures** and **$HOME/Footage**
  - You select a volume from which to copy media
  - Copies pics to **$HOME/Pictures/<user_specified_directory>**
  - Copies footage to **$HOME/Footage/<user_specified_directory>**
  - You specify if pics or footage is to be removed from your selected volume

- Pics and Footage (-fp OR -pf)
  - If not created, creates **$HOME/Pictures** and **$HOME/Footage**
  - You select a volume from which to copy media
  - Copies pics and footage to:
    - **$HOME/Pictures/<user_specified_directory>**
    - **$HOME/Footage/<user_specified_directory>**
  - You specify if pics and footage are to be removed from your selected volume

# Motivation
:movie_camera: :movie_camera: and lots of :camera: :camera:

# Installation
- First, make sure you have the **Xcode Command Line Tools** installed
- If not, follow this [How To Install Xcode Command Line Tools ](http://osxdaily.com/2014/02/12/install-command-line-tools-mac-os-x/)
- $ _git clone https://github.com/sammaniamsam/time-saver-scripts.git_

# License
Licensed under the MIT license. See License.md

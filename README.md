# Synopsis

## The scripts in time-saver-scripts are written for Mac OSX Terminal

### get_media.sh

- Copies any photos and/or videos from an external device
- Creates **Pictures** directory and/or **Footage** directory:
  - **/Users/<user_name>/Pictures**
  - **/Users/<user_name>/Footage**
- Within the **Pictures** directory and/or **Footage** directory:
  - You create a custom directory to store the copied media

# Code Examples
Example | Explanation
----------------- | -----------------
./get_media.sh **-p** | pics only
./get_media.sh **-f** | footage only
./get_media.sh **-fp** | pics and footage **-pf** OR **-fp**

# Motivation
:movie_camera: :movie_camera: and lots of :camera: :camera:

# Installation
- First, make sure you have the **Xcode Command Line Tools** installed
- If not, follow this [How To Install Xcode Command Line Tools ](http://osxdaily.com/2014/02/12/install-command-line-tools-mac-os-x/)
- $ _git clone https://github.com/sammaniamsam/time-saver-scripts.git_

# License
Licensed under the MIT license. See License.md

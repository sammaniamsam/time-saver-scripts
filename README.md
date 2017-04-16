# Synopsis

## The scripts in time-saver-scripts are written for Mac OSX Terminal

### get_media.sh

This script copies any photos and/or videos from an external
device and saves them in two separate directories
( **/Users/<user_name>/Pictures** and **/Users/<user_name>/Footage** )
in your home directory.

Within **/Users/<user_name>/Pictures** and **/Users/<user_name>/Footage**,
you create custom directories to store the media that was copied
from your external device.

# Code Examples
Example | Explanation
----------------- | -----------------
./get_media.sh **-p** | pics only
./get_media.sh **-f** | footage only
./get_media.sh **-fp** | pics and footage **-pf** OR **-fp**

# Motivation
:movie_camera: :movie_camera: and lots of :camera: :camera:

# Installation
> First, make sure you have the **Xcode Command Line Tools** installed.
> If not then follow this [tutorial](http://osxdaily.com/2014/02/12/install-command-line-tools-mac-os-x/)
> _git clone https://github.com/sammaniamsam/time-saver-scripts.git_

# License
Licensed under the MIT license. See License.md

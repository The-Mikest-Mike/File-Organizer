#!/bin/bash

# Script to organize files in the Downloads folder by their file types

# Set variable DIRECTORY to the path of the Downloads folder
DIRECTORY="$HOME/Downloads"

# Check if the Downloads directory exists
if [[ ! -d "$DIRECTORY" ]]; then
  # If the directory does not exist, display an error notification
  osascript -e 'display notification "Downloads directory does not exist." with title "Error"'
  exit 1  # Exit the script with a status code of 1, indicating an error
fi

# Change current directory to "Downloads" directory
cd "$DIRECTORY" || exit  # If changing directory fails, exit the script

# Iterate through all items in the current directory
for file in *; do
  # Skip the iteration if the current item (file) is a directory
  if [[ -d "$file" ]]; then
    continue  # Skips current iteration and go to the next item
  fi

  # Extract the file extension from the filename
  EXT="${file##*.}" # Use parameter expansion to get everyting after the last dot
  
  # Check if the file has no extension
  if [[ "$EXT" == "$file" ]]; then
    EXT="no_extension"  # Set 'no_extension' if the file has no extension
  fi

  # Create a directory named after the file extension if it doesn't exist
  mkdir -p "$EXT" # Ensures no error is raised if the directory already exists

  # Move the file into the corresponding extension folder
  mv "$file" "$EXT/"
done # End of the 'for' loop

# Display a notification to inform the user the organization process is complete
osascript -e 'display notification "The files in the Downloads Folder were organized by type!." with title "Organize Downloads"'

#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# Clean public folder
rm -rf public/*

# (Re)Build the project
hugo

# Add changes to git.
cd public
git add --all

# Commit changes.
msg="Publish site"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
git push

# Come Back up to the Project Root
cd ..
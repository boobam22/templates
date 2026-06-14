#!/bin/sh

set -e

if [ -n "$(ls -A)" ]; then
    echo "current directory must be empty."
    exit 1
fi

git clone --depth=1 --single-branch --branch="$1" "https://github.com/boobam22/templates.git" .
rm -rf .git init.sh README.md

PROJECT_NAME=$(basename "$PWD")

find . -type f -name "*.template" | while read -r file; do
    target="${file%.template}"
    PROJECT_NAME=$PROJECT_NAME envsubst '$PROJECT_NAME' < "$file" > "$target"
    rm "$file"
done

git init
git add .
git commit -m "init"
git remote add origin "git@github.com:boobam22/$PROJECT_NAME.git"

# mydir


# uses git's proprietory `ls-files` to see what files are being tracked
# since ls-files only shows tracked files, --others shows untracked files
# --exclude-standard exlcudes files that are git ignored
# --error-unmatch exits with non-zero status if any files are listed
if git ls-files --others --exclude-standard --error-unmatch > /dev/null 2>&1; then
    echo "Untracked files detected"
    ls
else
    echo "No untracked files"
fi


# user input for path
read -p "Enter a path: " path
echo "$path"

# check if path exists
if [[ -d "$path" ]]; then
    echo "Path exists"
else
    echo "Doesn't exist"
fi
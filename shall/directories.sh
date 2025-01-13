#!/bin/bash;

data="../data/directories.csv"

if [[ ! -f $data  ]]; then
    echo "File not found"
    exit 1
fi

tail -n +2 "$data" | while IFS=, read -r Folder Permission; do
    if [[ -d "$data" ]]; then
        #Directory exists update permission;
        chmod "$Permission" "$Folder"
    else
        #Create Directory then update permission;
        mkdir "$Folder"
        if [[ $? -eq 0 ]]
            then
            chmod "$Permission" "$Folder"
            echo "$Folder has been created and assigned permission of $Permission"
            ls -l -a
        fi
    fi
done
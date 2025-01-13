#!/bin/bash

data="../data/delete-user-db.csv"

if [[ ! -f $data ]]; then
    echo "File not found"
    exit 1
fi

#skip the first heading and parse CSV
tail -n +2 "$data" | while IFS= read -r user; do
    if [[ -n "$user" ]]; then
        userdel "$user" 
        if [[ $? -eq 0 ]]; then
            echo "$user has been deleted"
        else
            echo "Failed to delete $user, possibly because the user does not exist or is currently in use"
        fi
    fi
done
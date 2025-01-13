#!/bin/bash

data="../data/delete-group-db.csv"

if [[ ! -f $data ]]; then
    echo "File not found"
    exit 1
fi

#skip the first heading and parse CSV
tail -n +2 "$data" | while IFS= read -r group; do
    if [[ -n "$group" ]]; then
        groupdel "$group" &> /dev/null
    if [[ $? -ne 0 ]]; then
            echo "$group can't be deleted as it is assigned to users as a primary group"
        else
            echo "$group has been deleted"
        fi
    fi
done
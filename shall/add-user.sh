#!/bin/bash

data="../data/add-user-db.csv"

# Check if file exists
if [[ ! -f $data ]]; then
    echo "File Not Found"
    exit 1
fi

# Skip the first line and parse CSV
tail -n +2 "$data" | while IFS=, read -r User Group; do
    # Check if the group exists
    if ! getent group "$Group" > /dev/null; then
        groupadd "$Group"
        echo "Group added successfully! Group: $Group"
    fi

    # Check if the user exists
    if ! id "$User" > /dev/null 2>&1; then
        useradd -g "$Group" "$User"
        echo "User added successfully! User: $User, Group: $Group"
    else
        # Check if the user is already in the group
        current_group=$(id -gn "$User")
        if [[ "$current_group" != "$Group" ]]; then
            usermod -g "$Group" "$User"
            echo "User updated successfully! User: $User assigned to Group: $Group"
        else
            echo "No update needed. User: $User is already in Group: $Group"
        fi
    fi

    # Display the user's current details
    id "$User"
done

#!/bin/bash

read -p "What is the name of the user to be added? " NEW_USER;

read -sp "Please enter the password for $NEW_USER: " NEW_USER_PASSWORD;

if [[ -z "$NEW_USER" || -z "$NEW_USER_PASSWORD" ]]; then
    echo "Invalid user argments"
    exit 1;
fi

echo "Creating user & home directory for $NEW_USER";
useradd $NEW_USER -m -s /bin/bash

echo "Adding admin privileges to $NEW_USER";
usermod -aG sudo,adm $NEW_USER

echo "Setting password for $NEW_USER";
echo "$NEW_USER:$NEW_USER_PASSWORD" | chpasswd;

unset $NEW_USER;
unset $NEW_USER_PASSWORD;

echo "Finished";

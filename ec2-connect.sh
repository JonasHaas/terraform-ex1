#!/bin/bash
# This script connects to an EC2 instance using SSH and a private key file
# It saves the hassle of typing all the commands yourself
# Make sure your labsuser.pem file is always the right one and always in the Downloads folder 
# DON´T USE SUDO . it will mess with the $USER variable

# Authors: Yassin, Jonas
# Version: 0.4

# Set the path to the file that stores the IP address
ip_file="./creds/ec2-ip.txt"

# Check if the file exists and read the IP address from it
if [[ -f "$ip_file" ]]; then
    ip=$(cat "$ip_file")
fi

# If the IP address is not set, prompt the user to enter it
if [[ -z "$ip" ]]; then
    read -p 'Enter EC2 public IP address: ' ip
    echo "$ip" > "$ip_file"
fi

# Set the path to the private key file and set the permissions to read only
key_file="./creds/vockey.pem"
chmod 400 "$key_file"

# Loop forever and attempt to connect to the EC2 instance using SSH and the private key
while true; do
    # Try to connect using SSH
    ssh -i "$key_file" "ec2-user@$ip"

    # Check the exit status of the SSH command
    if [[ "$?" -ne 0 ]]; then
        echo "Connection failed. Retrying in 5 seconds..."
        sleep 5
    else
        break
    fi

    # Check if the user has entered "exit" and exit the script if they have
    read -t 0.1 -N 1 input
    if [[ $input == "e" ]]; then
        read -t 0.1 -N 1 input
        if [[ $input == "x" ]]; then
            read -t 0.1 -N 1 input
            if [[ $input == "i" ]]; then
                read -t 0.1 -N 1 input
                if [[ $input == "t" ]]; then
                    exit
                fi
            fi
        fi
    fi
done

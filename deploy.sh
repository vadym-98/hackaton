#!/bin/bash

GREEN='\033[1;32m'
NC='\033[0m' # No Color

echo "Building app..."
go build main.go
echo -e "${GREEN}[x] App is built${NC}"

echo "Sending files to remote server..."
rsync --archive --verbose --progress -e "ssh -i $HOME/.ssh/ec2Key.pem" /home/vadim/go/src/github.com/vadym-98/hackaton/main ec2-user@3.127.137.161:/home/ec2-user/go/src/github.com/vadym-98/hackaton
echo -e "${GREEN}[x] Files are sent${NC}"

echo "Removing old build..."
rm main
echo -e "${GREEN}[x] Old build removed${NC}"

echo "Run app remotely..."
ssh -i "$HOME/.ssh/ec2Key.pem" ec2-user@3.127.137.161 "pkill main; nohup /home/ec2-user/go/src/github.com/vadym-98/hackaton/main >./nohup.out 2>./nohup.err &"
echo -e "${GREEN}[x] App successfully started${NC}"
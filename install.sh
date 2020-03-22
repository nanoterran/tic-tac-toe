#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
WHITE='\033[0;37m'


install_dependencies() {
  sudo apt-get install -y build-essential
  sudo apt-get install -y luarocks
  sudo luarocks install busted
  sudo luarocks install luacov
}

install_dependencies
if [ $? -eq 0 ]; then
    echo -e "${GREEN}[+] Done Installing Dependencies${WHITE}"
else
    echo -e "${RED}[-] Error Installing Dependencies${WHITE}"
fi

git submodule init
git submodule update
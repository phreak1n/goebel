#!/bin/bash

# Determine OS platform
UNAME=$(uname | tr "[:upper:]" "[:lower:]")
# If Linux, try to determine specific distribution
if [ "$UNAME" == "linux" ]; then
    # If available, use LSB to identify distribution
    if [ -f /etc/lsb-release -o -d /etc/lsb-release.d ]; then
        export DISTRO=$(lsb_release -i | cut -d: -f2 | sed s/'^\t'//)
    # Otherwise, use release info file
    else
        export DISTRO=$(ls -d /etc/[A-Za-z]*[_-][rv]e[lr]* | grep -v "lsb" | cut -d'/' -f3 | cut -d'-' -f1 | cut -d'_' -f1)
    fi
fi
# For everything else (or if above failed), just use generic identifier
[ "$DISTRO" == "" ] && export DISTRO=$UNAME
unset UNAME

# Setup ubuntu
if [ $DISTRO = 'Ubuntu' ]; then #TODO: check os detceton script if output is "Ubuntu"
   sudo apt update && \
       sudo apt install -y ocrmypdf tesseract-ocr tesseract-ocr-deu tesseract-ocr-spa tesseract-ocr-fra python3-pip wget && \
       sudo pip install ocrmypdfgui && \
       cd ~/.local/share/applications && \
       wget https://raw.githubusercontent.com/phreak1n/goebel/main/ocrtool/OCRtool.desktop
fi

# Setup LinuxMint
if [ $DISTRO = 'LinuxMint' ]; then
   sudo apt install snapd -y && \
       sudo snap install ocrmypdfgui
fi

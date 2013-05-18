#!/bin/sh

PLIST=com.neilcowburn.bluud.plist

cp -R ./DerivedData/bluu/Build/Products/Debug/bluu.app /Applications
cp ./bluu/$PLIST ~/Library/LaunchAgents/$PLIST
launchctl load ~/Library/LaunchAgents/$PLIST
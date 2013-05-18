#!/bin/sh

PLIST=com.neilcowburn.bluud.plist

launchctl unload ~/Library/LaunchAgents/$PLIST
rm ~/Library/LaunchAgents/$PLIST
rm -rf /Applications/bluu.app
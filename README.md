# Bluu

## Overview

Bluu is a small daemon that monitors for changes in your display configuration and toggles Bluetooth on or off. 

Simply plug in an external display to turn on Bluetooth. Unplug the external display and Bluetooth is turned off. 

## Getting started

Build the project in Xcode and run ```install.sh``` to install & activate the daemon.

Run ```uninstall.sh``` to terminate & delete the daemon. 

## Notifications

The daemon will show notifications in Notification Center for Mountain Lion users whenever it toggles Bluetooth. These can be turned on and off by setting the ```displayNotifications``` preference as follows:

### Turn notifications on

```
defaults write com.neilcowburn.btextd displayNotifications 1
```

### Turn notifications off

```
defaults write com.neilcowburn.btextd displayNotifications 0
```

## FAQ

### What about running an external display with the lid closed?

It Just Works™.

### Are you that lazy?!

Yes. 

## License

[MIT license](http://neil.mit-license.org)

Copyright (c) 2013 Neil Cowburn (http://github.com/neilco/)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
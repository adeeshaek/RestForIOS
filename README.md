RestForIOS
==========

A simple REST framework for use in iOS applications.

Installation
------------
* Cocoapods: The quickest way to install RestForIOS is to use Cocoapods. Add the pod **'RestForIOS'** to your Podfile
* If you don't want to use cocoapods (and you really should), just include RestForIOS.h to make use of the class methods for accessing RESTful APIs

Usage
-----
The methods provided in RestForIOS.h can be used to construct a wrapper class for the RESTful API you wish to access. All methods are fully documented in RestForIOS.h, and are appledoc'd (so the documentation shows up in XCode).

All the methods in RestForIOS are class methods (+), so if you have a functional bent to your programming style, RestForIOS is a good fit. I also made them class methods in order to more easily deploy them through a background thread.

Limitations
-----------
For now, the POST methods provided in this framework only work with the Form/Data style of POST. 

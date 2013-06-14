docpad-plugin-facebookcomments
==============================

@getFacebookComments() for [Docpad](http://docpad.org/) !

Modeled after [docpad-plugin-services](https://github.com/docpad/docpad-plugin-services). By [@mikeumus](http://twitter.com/mikeumus) of [MDM](http://massdistributionmedia.com/)

#### It comes with options!
Arugments must do in this order: @getFacebookComments(1010,'dark',100, 'time')
 - width option: supports only numbers, no '30px' or '100%'
 - colorscheme options: 'light' or 'dark' 
 - order_by options: 'social', 'reverse_time', 'time'. Default: 'social'
 - Not implemented, mobile: whether to show the mobile-optimized version. Default: auto-detect.

 So for example the follow posted in a page.html.eco:
 `@getFacebookComments(1010,'dark',100, 'time')`

 Will product something like this:
![Alt text](https://googledrive.com/host/0B9LVk4xbDIJTT0hOa1lyMGpfOUk/Sol%20X%20Interview%20by%20Subset%203%20%20%20RL%20Spike%20Mark%201.png "picture of dark facebook comments on solspike.com")

# Configuration

There are a few config files in this directory, please see below for information about each one.

To get up and running there are only two conf files you must edit. The first is to enter your list of feed URLs in feeds.conf and second, if you want more than 1 feed on the screen at a time, edit the `on_screen` option in pi_video_matrix.conf.

## pi_video_matrix.conf
This is the configuration file for the pi_video_matrix program intended to display a matrix of video feeds such as those from a CCTV camera system (there is a known compatibility issue with Hikvision cameras).

If any variables are left blank defaults will be used.

In it you can configure the following options:

### Display blanking - 'blank'
The `blank` option will black out the Raspberry Pi's display to hide the command line boot text whilst the cameras are loading. It is recommended that you enable this setting by setting it to blank=true.

It is disabled by default.

### Number of visible feeds - `on_screen`
The `on_screen` option allows you to specify how many video feeds you want visible on screen at one time. There are 3 matrices that can be configured automatically, these are shown below.

The default value is 1, which equates to 1 full-screen feed and no matrix.

<pre>
       2 x 2 grid                     3 x 3 grid with 1 large                      3 x 3 grid
 _____________________                 _____________________                 _____________________
|  ________ ________  |  _____        |  ___________ _____  |  _____        |  _____ _____ _____  |  _____
| |    1   |    2   | | | 5+  |       | |     1     |  2  | | | 7+  |       | |  1  |  2  |  3  | | | 10+ |
| |        |        | | |_____|       | |           |_____| | |_____|       | |_____|_____|_____| | |_____|
| |________|________| |               | |           |  3  | |               | |  4  |  5  |  6  | |
| |    3   |    4   | |               | |___________|_____| |               | |_____|_____|_____| | 
| |        |        | |               | |  4  |  5  |  6  | |               | |  7  |  8  |  9  | |
| |________|________| |               | |_____|_____|_____| |               | |_____|_____|_____| |
|_____________________|               |_____________________|               |_____________________|
        __|_|__                               __|_|__                               __|_|__
</pre>

### Aspect ratio - `stretch`
The `stretch` option allows you to stretch your matrix and therefore your video feeds to fill a monitors available resolution. By default an aspect ratio of 16:9 is maintained, as this is the standard ratio used by most monitors and video feeds. This setting will have no effect if your monitor is 16:9 and can be ignored.

This is disabled by default.

### Rotation - `rotatedelay`, `rotaterev`
The `rotatedelay` option determines how often video feeds are rotated, in seconds, when you have more feeds than visible windows in your matrix.

The default value is 5.

The `rotaterev` option reverse the direction the windows are rotated. By default windows are rotated from bottom right to top left.

This is disabled by default.

### Reliability - `omx_timeout`, `startsleep`, `feedlseep`
The `omx_timeout` option specifies the network timeout for omxplayer, if you experience reliability issues while establishing connections to your video feeds it is recommended to increase this value. Higher resolution feeds and bandwidth restrictions can also benefit from a higher value.

The default value is 30.

The `startsleep` and `feedsleep` options determine how long the program will wait for omxplayer to establish a connection to a video a feed. Again as per the above if you experience issues establishing connections to your feeds you can try to increase these values.

The default value for `startsleep` is 3.
The default value for `feedlseep` is 1.

## feeds.conf
This configuration file is the only one you must make some amendments to if you want the container to do anything, where you need to list your video feeds, one per line. You can add text comments or comment out lines using # character.

## schedule.conf
Most monitors are not designed to be run 24x7, doing so will drastically shorten it's lifespan. If you monitor supports sleeping when there's no video input, you can configure times for the system to automatically switch on and off. If either field in each on/off pair is left blank, the system will remain off.

Please enter times in 24 hour notation with no additional characters  
Example: `weekday_on=0600`

By default the schedule is permanently on.

## example.layout.conf
This file explains how you can create your own matrix if you don't like the default options. You can create the file layout.conf or rename example.layout.conf and edit that in place. This will cause the default.layout.conf to not be created/updated when the program is run and it will load your layout instead.

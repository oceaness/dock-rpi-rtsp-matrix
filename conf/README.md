# Configuration

There are a few config files in this directory, please see below for information about each one.

## pi_video_matrix.conf

This is the configuration file for the pi_video_matrix program intended to display a matrix of video feeds such as those from a CCTV camera system (there is a known compatibility issue with Hikvision cameras).

If any variables are left blank defaults will be used.

In it you can configure the following options:

### Display blanking
This will black out the Raspberry Pi's display to hide the command line boot text whilst the cameras are loading. For this reason it is recommened that you enable this setting by setting it to blank=true.
It is disabled by default.

### Number of visible feeds
This allows you to specify how many video feeds you want visible on screen at one time. Recommended values are 1, 4 ,6 , and 9, as these are the pre-programmed layouts.

<pre>
   1920/2=960
 _______________ 
|  _____ _____  |  _____
| |  1  |  2  | | | 5/6 |
| |_____|_____| | |_____|
| |  3  |  4  | |          1080/2=540
| |_____|_____| |
|_______________|
     __|_|__
</pre>

### Aspect ratio

### Rotation

### Reliability

## feeds.conf



## schedule.conf



## example.layout.conf


# mov2gif - Command Line Tool to convert .mov Recordings to Gifs

This is a tool I generated using ChatGPT to make it easier to convert Mac screen recordings to gif on my computer locally.

## Using mov2gif

When you pass in a folder, let's say `screenRecordingFolder/`, running...

```bash
mov2gif screenRecordingFolder
```

It will create a new folder called `screenRecordingFolder_gifs` in the same directory and populate it with all the `*.mov` files but as `*.gif` instead! 

If you pass in a single file, it will create a new file with the same name in the same directory...

```bash
mov2gif myScreenRecording.mov
```

will create a new file called `myScreenRecording.gif` instead! Yay!

## Installing mov2gif

1. Download the `mov2gif_install` from this repo.
2. In the directory that you downloaded this to, run this command to begin the installation process:

```bash
chmod +x mov2gif_install && sudo ./mov2gif_install && rm mov2gif_install
```

3. It is now installed to `/usr/local/bin` ! Yay.
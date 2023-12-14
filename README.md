# mov2gif - Command Line Tool to convert .mov Recordings to Gifs

This is a tool I generated using ChatGPT to make it easier to convert Mac screen recordings to gif on my computer locally.

----

## Installing mov2gif

1. Make sure you have `brew` installed, and the necessary packages:

```bash
brew install ffmpeg gifsicle
```

2. Download the `install_mov2gif.sh` from this repo.
3. In the directory that you downloaded this to, run this command to begin the installation process:

```bash
chmod +x install_mov2gif.sh && sudo ./install_mov2gif.sh && rm install_mov2gif.sh
```

3. It is now installed to `/usr/local/bin` ! Yay.

----

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

If you forget, you can use `mov2gif --help` or `mov2gif -h` to help jog your memory!

will create a new file called `myScreenRecording.gif` instead! Yay!


# torch-ffmpeg
This is a simple wrapper for FFmpeg in Torch7. There are a couple of other wrappers for FFmpeg already, but I found them difficult to install.

This wrapper:
- talks to FFmpeg via Unix pipes so it is easy to install
- it is a single Lua file, so easy to modify 
- it doesn't write to disk, so it is reasonably fast

## Usage

The `demo.lua` code shows how to use it. It's pretty easy:

    require 'torch-ffmpeg'
    vid = FFmpeg('video.mp4')
    frames = vid:read(10)
    vid:close()
  
`frames` will be a T x 3 x W x H tensor, where T is number of frames read, and W and H is width and height. In the example above, T = 10.

## Hacking

If you want to, for example, change the frame rate or seek to different parts of the video, you can modify the `ffmpeg` command in `torch-ffmpeg.lua` as you see fit. It will accept any command line option your ffmpeg program accepts.

# torch-ffmpeg
This is a simple wrapper for FFmpeg in Torch7. There are a couple of other wrappers for FFmpeg already, but I found them difficult to install.

This wrapper:
- talks to FFmpeg via Unix pipes so it is easy to install
- it is a single Lua file (and only 50 lines), so easy to modify 
- it doesn't write to disk, so it is reasonably fast

## Usage

The `demo.lua` code shows how to use it. It's pretty easy:

    require 'torch-ffmpeg'
    vid = FFmpeg('video.mp4')
    frames = vid:read(10)
    vid:close()
  
`frames` will be a T x 3 x W x H tensor, where T is number of frames read, and W and H is width and height. In the example above, T = 10.

## Options

If you want to specify different options, such as a different starting point or change the frame rate, you can pass additional options to FFmpeg like so:

    vid = FFmpeg('video.mp4', '-r 10') -- 10 fps
    vid = FFmpeg('video.mp4', '-ss 00:00:07') -- seek to 7sec mark

Note that seeking is approximate, but fast.

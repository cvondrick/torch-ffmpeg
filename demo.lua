require 'torch-ffmpeg'

-- Open up video
-- If you a recent enough FFmpeg, it can read from HTTP 
vid = FFmpeg('http://www.flickr.com/videos/29833755@N08/4415516615/play/orig/4d40e1ea19')

-- Reads 10 frames into a tensor
frames = vid:read(10)

print('Frame tensor is size:')
print(frames:size())

require 'image'
image.save('foo.jpg', frames[1])

---- Reads frame by frame until there are no more
counter = 0
while true do
  if vid:read(1) == nil then
    break
  end
  counter = counter + 1
end
print('There are '.. counter .. ' more frames')

-- Close the stream
vid:close()

-- Retrieve some meta-data
print('Some stats:')
print(vid:stats())

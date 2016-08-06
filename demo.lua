require 'torch-ffmpeg'

-- Open up video
vid = FFmpeg('/data/vision/torralba/crossmodal/flickr_videos//videos2/7/4/1/2/4/0/6/4/5574124064.mp4')

print('Width', vid.width)
print('Height', vid.height)
print('Duration in Seconds', vid.duration)

-- Reads 10 frames into a tensor
frames = vid:read(10)

print('Frame tensor is size:')
print(frames:size())

require 'image'
image.save('foo.jpg', frames[1])

-- Reads frame by frame until there are no more
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

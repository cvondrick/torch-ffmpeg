do
  local FFmpeg = torch.class('FFmpeg')

  function FFmpeg:__init(video_path)
    self.video_path = video_path

    -- use ffprobe to find width/height of video
    -- this will store self.width, self.height, self.duration
    local cmd = 'ffprobe -select_streams v -v error -show_entries stream=width,height,duration -of default=noprint_wrappers=1 ' .. video_path
    local fd = assert(torch.PipeFile(cmd))
    for i=1,3 do
      local split = {}
      for k in string.gmatch(fd:readString('*l'), '[^=]*') do table.insert(split, k) end
      self[split[1]] = tonumber(split[3])
    end
    fd:close()

    -- open ffmpeg pipe
    -- this subprocess will send raw RGB values to us, corresponding to frames
    local cmd = 'ffmpeg -i ' .. video_path .. ' -f image2pipe -pix_fmt rgb24 -loglevel fatal -vcodec rawvideo -'
    self.fd = assert(torch.PipeFile(cmd))
    self.fd:binary()
    self.fd:quiet()
  end

  function FFmpeg:read(nframes)
    local t = torch.ByteTensor(nframes, self.height, self.width, 3)
    self.fd:readByte(t:storage())

    if self.fd:hasError() then
      return nil
    end

    t = t:permute(1,4,2,3)
    return t
  end

  function FFmpeg:close()
    self.fd:close()
  end
end
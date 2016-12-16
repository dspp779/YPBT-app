# frozen_string_literal: true

# parse popular videos info from YPBT-api for html rendering
class VideoPopView < SimpleDelegator
  def initialize(video_pop_info)
    super(video_pop_info)
  end

  def video_viewer_url
    youtube_url = "https://www.youtube.com/watch?v=#{video_id}"
    "/video_viewer/?video_url=#{youtube_url}"
  end

  def yt_channel_url
    "https://www.youtube.com/channel/#{channel_id}"
  end
end

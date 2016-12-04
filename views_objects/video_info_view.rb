# frozen_string_literal: true

class VideoInfoView
  attr_reader :video_id, :title, :description, :view_count, :like_count,
              :dislike_count, :duration, :channel_title, :channel_image_url,
              :channel_description
  def initialize(video)
    @video_id = video.video_id
    @title = video.title
    @description = video.description
    @view_count = video.view_count
    @like_count = video.like_count
    @dislike_count = video.dislike_count
    @duration = video.duration
  end

  def description_html
    @description.gsub(/\n/, '<br>')
  end
end

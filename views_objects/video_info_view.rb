# frozen_string_literal: true

VideoInfoView = Struct.new(
  :video_id, :title, :description, :view_count, :like_count, :dislike_count,
  :duration
)

# frozen_string_literal: true
require 'ruby-duration'

class TimeTag
  attr_accessor :time_tag_id, :start_time, :end_time, :tag_type,
                :start_time_percentage, :end_time_percentage, :click_count,
                :like_count, :like_color, :comment_text_display,
                :comment_author_name, :comment_author_channel_url,
                :comment_author_image_url
  def start_time_second
    Duration.new(start_time).total
  end
end

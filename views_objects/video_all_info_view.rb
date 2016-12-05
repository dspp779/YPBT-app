# frozen_string_literal: true
require 'ruby-duration'

class VideoAllInfoView
  attr_accessor :video_info, :time_tags
  def sort_tags
    like_counts = time_tags.map(&:tag.like_count)
    like_min = like_counts.min
    like_max = like_counts.max
    like_range = like_max - like_min
    time_tags.each do |tag|
      tag.start_time_second = Duration.new(tag.start_time).total
      tag.like_color = 160 - ((tag.like_count - like_min) * 100 / like_range)
    end
    time_tags.sort! { |a, b| a.like_color <=> b.like_color }.reverse!
    time_tags
  end
end

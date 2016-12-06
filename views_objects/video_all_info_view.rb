# frozen_string_literal: true

class VideoAllInfoView
  attr_accessor :video_info, :_time_tags
  def time_tags
    return _time_tags if _time_tags.empty?
    like_counts = _time_tags.map(&:like_count)
    like_min = like_counts.min
    like_max = like_counts.max
    like_range = like_max - like_min
    _time_tags.each do |tag|
      if like_range.zero?
        tag.like_color = 160
      else
        tag.like_color = 160 - ((tag.like_count - like_min) * 100 / like_range)
      end
    end
    _time_tags.sort! { |a, b| a.like_color <=> b.like_color }.reverse!
  end
end

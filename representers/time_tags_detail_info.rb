# frozen_string_literal: true

# Represents overall video information for JSON API output
class TimeTagsDetailInfo < Roar::Decorator
  include Roar::JSON
  property :time_tag_id
  property :start_time
  property :end_time, render_nil: true
  property :tag_type, render_nil: true
  property :start_time_percentage
  property :end_time_percentage, render_nil: true
  property :click_count
  property :like_count
  property :comment_text_display
  property :comment_author_name
  property :comment_author_image_url
  property :comment_author_channel_url
end

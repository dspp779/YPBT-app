# frozen_string_literal: true

# Represents overall popular video information for JSON API output
class VideoPopInfoRepresenter < Roar::Decorator
  include Roar::JSON
  property :video_id
  property :title
  property :channel_id
  property :channel_title
  property :view_count
  property :like_count
  property :thumbnail_url
end

# frozen_string_literal: true

# Represents overall video information for JSON API output
class TimeTagsInfo < Roar::Decorator
  include Representable::Hash
  include Representable::Hash::AllowSymbols
  property :time_tag_id
  property :start_time
  property :end_time, render_nil: true
  property :tag_type, render_nil: true
  property :start_time_percentage
  property :end_time_percentage, render_nil: true
  property :like_count
end

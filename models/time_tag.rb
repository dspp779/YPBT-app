# frozen_string_literal: true

TimeTag = Struct.new :time_tag_id, :start_time, :end_time, :tag_type,
                     :start_time_percentage, :end_time_percentage, :like_count,
                     :like_color, :start_time_second

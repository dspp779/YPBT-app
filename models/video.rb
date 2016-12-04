# frozen_string_literal: true

Video = Struct.new :video_id, :title, :description, :view_count, :like_count,
                   :dislike_count, :duration, :channel_id, :channel_title,
                   :channel_description, :channel_image_url

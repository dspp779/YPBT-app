# frozen_string_literal: true

# Search user query video
class SearchVideoWholeInfo
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  register :search_video, lambda { |url_request|
    video_result = SearchVideo.call(url_request)
    if video_result.success?
      video_all_info = VideoAllInfoView.new
      video_all_info.video_info = VideoInfoView.new(video_result.value)
      Right(video_all_info)
    else
      message = ErrorFlattener.new(
        ValidationError.new(url_request)
      ).to_s
      Left(Error.new(message))
    end
  }

  register :search_time_tags, lambda { |video_all_info|
    video_id = video_all_info.video_info.video_id
    result = SearchTimeTags.call(video_id)
    if result.success?
      video_all_info._time_tags = result.value
      Right(video_all_info)
    else
      Left(Error.new('Time tag not found'))
    end
  }

  def self.call(url_request)
    Dry.Transaction(container: self) do
      step :search_video
      #step :search_time_tags
    end.call(url_request)
  end
end

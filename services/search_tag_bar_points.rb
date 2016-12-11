# frozen_string_literal: true

# Search tag bar points
class SearchTagBarPoints
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  register :search_time_tags, lambda { |params|
    video_id = params[:video_id]
    result = SearchTimeTags.call(video_id)
    if result.success?
      video_all_info = VideoAllInfoView.new
      video_all_info._time_tags = result.value
      Right(video_all_info)
    else
      Left(Error.new('Time tag not found'))
    end
  }

  def self.call(params)
    Dry.Transaction(container: self) do
      step :search_time_tags
    end.call(params)
  end
end

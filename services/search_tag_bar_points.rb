# frozen_string_literal: true

# Search tag bar points
class SearchTagBarPoints
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  register :api_call, lambda { |params|
    video_id = params[:video_id]

    begin
      Right(HTTP.get("#{YouTagit.config.YPBT_API}/TimeTags/#{video_id}"))
    rescue
      Left(Error.new('Our servers failed - we are investigating!'))
    end
  }

  register :parse_api_result, lambda { |http_result|
    if http_result.status == 200
      data = JSON.parse(http_result.body.to_s)
      tags = data.map { |tag| TimeTagsInfo.new(TimeTag.new).from_hash(tag) }
      Right(tags)
    elsif http_result.status == 404
      Right([])
    else
      Left(Error.new(:internal_error,
                     'Our servers failed - we are investigating!'))
    end
  }

  register :search_time_tags, lambda { |tags|
    video_all_info = VideoAllInfoView.new
    video_all_info._time_tags = tags
    Right(video_all_info)
  }

  def self.call(params)
    Dry.Transaction(container: self) do
      step :api_call
      step :parse_api_result
      step :search_time_tags
    end.call(params)
  end
end

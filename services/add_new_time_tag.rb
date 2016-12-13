# frozen_string_literal: true

# Add add new timetag in API database
class AddNewTimeTag
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  register :api_call, lambda { |params|
    url = "#{YouTagit.config.YPBT_API}/TimeTag"
    params[:api_key] = YouTagit.config.YOUTUBE_API_KEY
    response = HTTP.post(url, json: params)

    if response.status == 200
      data = [JSON.parse(response.body.to_s)]
      tags = data.map { |tag| TimeTagsInfo.new(TimeTag.new).from_hash(tag) }
      Right(tags)
    else
      Left(Error.new(:internal_error,
                     'Our servers failed - we are investigating!'))
    end
  }

  register :render_new_tag_point, lambda { |tags|
    video_all_info = VideoAllInfoView.new
    video_all_info._time_tags = tags
    Right(video_all_info)
  }

  def self.call(params)
    Dry.Transaction(container: self) do
      step :api_call
      step :render_new_tag_point
    end.call(params)
  end
end

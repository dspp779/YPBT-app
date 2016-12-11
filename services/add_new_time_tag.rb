# frozen_string_literal: true

# Add add new timetag in API database
class AddNewTimeTag
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  register :api_call, lambda { |request|
    url = "#{YouTagit.config.YPBT_API}/TimeTag"
    params = {
      video_id: request[:video_id],
      start_time: request[:start_time],
      tag_type: request[:tag_type],
      comment_text_display: request[:comment_text_display],
      api_key: YouTagit.config.YOUTUBE_API_KEY
    }
    params[:end_time] = request[:end_time] unless request[:end_time].nil?
    response = HTTP.post(url, :json => params)

    begin response.status == 200
      Right(response.body.to_json)
    rescue
      Left(Error.new('Our servers failed - we are investigating!'))
    end
  }

  register :return_api_result, lambda { |http_result|
    if http_result.status == 200
      data = JSON.parse(http_result.body.to_s)
      tags = data.map { |tag| TimeTagsInfo.new(TimeTag.new).from_hash(tag) }
      Right(tags)
    elsif http_result.status == 404
      Right([])
    else
      Left(ErrorRepresenter.new('Time tag not found'))
    end
  }

  def self.call(request)
    Dry.Transaction(container: self) do
      step :api_call
      #step :return_api_result
    end.call(request)
  end
end

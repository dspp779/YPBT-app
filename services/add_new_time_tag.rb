# frozen_string_literal: true

# Add add new timetag in API database
class AddNewTimeTag
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  register :api_call, lambda { |request|
    body_params = JSON.parse request.body.read
    url = "#{YouTagit.config.YPBT_API}/TimeTag"
    params = {
      video_id: body_params['video_id'],
      start_time: body_params['start_time'],
      tag_type: body_params['tag_type'],
      comment_text_display: body_params['comment_text_display'],
      api_key: YouTagit.config.YOUTUBE_API_KEY
    }
    unless body_params[:end_time].nil?
      params[:end_time] = body_params[:end_time]
    end
    response = HTTP.post(url, :json => params)

    if response.status == 200
      Right(response.body.to_json)
    else
      Left(Error.new('Our servers failed - we are investigating!'))
    end
  }

  def self.call(request)
    Dry.Transaction(container: self) do
      step :api_call
    end.call(request)
  end
end

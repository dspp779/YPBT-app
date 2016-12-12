# frozen_string_literal: true

# Add one like count on seleted timetag in API database
class TimetagAddOneLike
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  register :api_call, lambda { |params|
    url = "#{YouTagit.config.YPBT_API}/TimeTag/add_one_like"
    params[:api_key] = YouTagit.config.YOUTUBE_API_KEY
    response = HTTP.put(url, json: params)
    if response.status == 200
      Right(response.body.to_json)
    else
      Left(Error.new(:internal_error,
                     'Our servers failed - we are investigating!'))
    end
  }

  def self.call(request)
    Dry.Transaction(container: self) do
      step :api_call
    end.call(request)
  end
end

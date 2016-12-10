# frozen_string_literal: true

# Add one like count on seleted timetag in API database
class TimetagAddOneLike
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  register :api_call, lambda { |timetag_id|
    url = "#{YouTagit.config.YPBT_API}/TimeTag/add_one_like"
    params = {
      time_tag_id: timetag_id,
      api_key: YouTagit.config.YOUTUBE_API_KEY
    }
    response = HTTP.put(url, :json => params)

    begin response.status == 200
      Right()
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

  def self.call(timetag_id)
    Dry.Transaction(container: self) do
      step :api_call
      #step :return_api_result
    end.call(timetag_id)
  end
end

# frozen_string_literal: true

# Search user query video
class SearchVideo
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  YT_URL_REGEX = %r{https://www.youtube.com/watch\?v=(\S[^&]+)}

  register :validate_url_request, lambda { |url_request|
    if url_request.success?
      video_url = url_request[:video_url]
      video_id = video_url.match(YT_URL_REGEX)[1]
      Right(video_id)
    else
      message = ErrorFlattener.new(
        ValidationError.new(url_request)
      ).to_s
      Left(Error.new(message))
    end
  }

  register :api_call, lambda { |video_id|
    begin
      Right(HTTP.get("#{YouTagit.config.YPBT_API}/Video/#{video_id}"))
    rescue
      Left(Error.new('Our servers failed - we are investigating!'))
    end
  }

  register :return_api_result, lambda { |http_result|
    data = http_result.body.to_s
    if http_result.status == 200
      Right(VideoInfoRepresenter.new(Video.new).from_json(data))
    else
      message = ErrorFlattener.new(
        ApiErrorRepresenter.new(ApiError.new).from_json(data)
      ).to_s
      Left(Error.new(message))
    end
  }

  def self.call(url_request)
    Dry.Transaction(container: self) do
      step :validate_url_request
      step :api_call
      step :return_api_result
    end.call(url_request)
  end
end

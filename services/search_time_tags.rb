# frozen_string_literal: true

# Search user query video
=begin
class SearchTimeTags
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  register :api_call, lambda { |video_id|
    begin
      Right(HTTP.get("#{YouTagit.config.YPBT_API}/TimeTags/#{video_id}"))
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

  def self.call(video_id)
    Dry.Transaction(container: self) do
      step :api_call
      step :return_api_result
    end.call(video_id)
  end
end
=end

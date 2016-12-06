# frozen_string_literal: true

# Search user query video
class SearchTimeTagDetail
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  register :api_tag_detail, lambda { |tag_id|
    begin
      Right(HTTP.get("#{YouTagit.config.YPBT_API}/TimeTag/#{tag_id}"))
    rescue
      Left(Error.new('Our servers failed - we are investigating!'))
    end
  }

  register :return_api_result, lambda { |http_result|
    if http_result.status == 200
      data = http_result.body.to_s
      tag = TimeTagsDetailInfo.new(TimeTag.new).from_json(data)
      Right(TimeTagsDetailView.new(tag))
    else
      Left(ErrorRepresenter.new('Time tag not found'))
    end
  }

  def self.call(tag_id)
    Dry.Transaction(container: self) do
      step :api_tag_detail
      step :return_api_result
    end.call(tag_id)
  end
end

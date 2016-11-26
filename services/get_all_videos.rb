# frozen_string_literal: true

# Gets list of all videos from API
class GetAllVideos
  extend Dry::Monads::Either::Mixin

  def self.call
    results = HTTP.get("#{YouTagit.config.YPBT_API}/video")
    Right(VideosRepresenter.new(Videos.new).from_json(results.body))
  rescue
    Left(Error.new('Our servers failed - we are investigating!'))
  end
end

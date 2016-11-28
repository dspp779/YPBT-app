# frozen_string_literal: true

UrlRequest = Dry::Validation.Form do
  required(:video_url).filled(format?:
    %r{https://www.youtube.com/watch\?v=(\S[^&]+)})
  configure do
    config.messages_file = File.join(__dir__, 'errors/url_request.yml')
  end
end

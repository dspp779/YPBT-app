# frozen_string_literal: true
ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'minitest/rg'

require 'watir'
require 'headless'
require 'page-object'
require 'rack/test'

require './init.rb'

include Rack::Test::Methods

def app
  YouTagit
end

unless ENV['YOUTUBE_API_KEY']
  ENV['YOUTUBE_API_KEY'] = app.config.YOUTUBE_API_KEY
end

unless ENV['YPBT_API']
  ENV['YPBT_API'] = app.config.YPBT_API
end





EXISTS_VIDEO_URL = 'https://www.youtube.com/watch?v=OyDSCKYz5sA'
NEW_GROUP_URL = 'https://www.youtube.com/watch?v=VLdmEDOAA4A'
INVALID_GROUP_URL = 'https://www.youtube.com/watch?v=that_does_not_exist404'
BAD_GROUP_URL = 'htt://www.youtube'

HOST = 'http://localhost:9000/'

# Helper methods
def homepage
  HOST
end

def video_viewer_page(url)
  "#{HOST}/video_viewer?video_url=#{url}"
end

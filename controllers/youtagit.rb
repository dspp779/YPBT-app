# frozen_string_literal: true

# YouTagit web application
class YouTagit < Sinatra::Base
  # Home page: show list of all groups
  get '/?' do
=begin
    result = GetAllGroups.call
    if result.success?
      @data = result.value
    else
      flash[:error] = result.value.message
    end
=end
    slim :video
  end

  post '/new_video/?' do
    if true
      flash[:notice] = "Video successfully added"
    end

    redirect '/'
  end
end

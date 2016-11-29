# frozen_string_literal: true

# YouTagit web application
class YouTagit < Sinatra::Base
  # Home page: show list of all Videos
  get '/?' do

    result = GetAllVideos.call
    if result.success?
      @data = result.value
    else
      #flash[:error] = result.value.message
    end

    slim :home_page
  end

  post '/search_video/?' do
    url_request = UrlRequest.call(params)
    results = SearchVideo.call(url_request)

    if results.success?
      video_info = results.value
      @video = video_info
      slim :video_viewer
    else
      flash[:error] = results.value.message
      redirect '/'
    end
  end

  post '/new_video/?' do
  
    url_request = UrlRequest.call(params)
    result = CreateNewVideo.call(url_request)

    if result.success?
      flash[:notice] = 'Group successfully added'
    else
      flash[:error] = result.value.message
    end

    redirect '/'
  end
end

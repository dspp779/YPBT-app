# frozen_string_literal: true

# YouTagit web application
class YouTagit < Sinatra::Base
  # Home page: show list of all Videos
  get '/?' do
    result = GetPopVideos.call(params)

    if result.success?
      @videos_pop_view = result.value
      slim :home_page
    else
      flash[:error] = result.value.message
    end
  end

  get '/video_viewer/?' do
    url_request = UrlRequest.call(params)
    results = SearchVideoWholeInfo.call(url_request)

    if results.success?
      @whole_info = results.value
      slim :video_viewer
    else
      #flash[:error] = results.value.message
      redirect '/'
    end
  end
=begin
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
=end
end

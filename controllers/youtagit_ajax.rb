class YouTagit < Sinatra::Base
  get '/time_tag/:id/?' do
    results = SearchTimeTagDetail.call(params[:id])
    if results.success?
      @tag = results.value
      slim :video_viewer_tag_popover, layout: false
    else
      flash[:error] = results.value.message
      redirect '/'
    end
  end
end

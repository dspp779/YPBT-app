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

  put '/add_new_time_tag/?' do
    results = AddNewTimeTag.call(request)

    if results.success?
      results.value
    else
      flash[:error] = results.value.message
    end
  end

  put '/timetag_add_one_like/?' do
    results = TimetagAddOneLike.call(params[:id])

    if results.success?
      results.value
    else
      flash[:error] = results.value.message
    end
  end
end

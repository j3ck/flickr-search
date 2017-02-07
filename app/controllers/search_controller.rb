class SearchController < ApplicationController
  def index
    query = params[:query] || 'random'
    @results = FLICKR.photos.search(text: query)
  end

  def show
    @photo = FLICKR.photos.find_by_id(params['id'])
  end
end

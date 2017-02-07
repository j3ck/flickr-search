class SearchController < ApplicationController
  def index
    query = params[:query] || 'random'
    page = params[:page] || 0
    @results = FLICKR.photos.search(text: query, page: page, per_page: 50)
  end

  def show
    @photo = FLICKR.photos.find_by_id(params['id'])
  end
end

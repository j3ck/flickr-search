class SearchController < ApplicationController
  def index
    query = params[:query] || 'random'
    page = params[:page] || 0
    @results = cached_search_result(query, page)
  end

  def show
    @photo = FLICKR.photos.find_by_id(params['id'])
  end

  private

  def cached_search_result(query, page)
    Rails.cache.fetch("#{query}-#{page}", expires_in: 1.hour) do
      FLICKR.photos.search(text: query, page: page, per_page: 50)
    end
  end
end

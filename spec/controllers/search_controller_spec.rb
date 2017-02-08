require 'rails_helper'

describe SearchController do

  describe 'GET #index' do
    before do
      xml = File.read(File.join(Rails.root, 'spec/fixtures/photos', 'get_search.xml'))
      FLICKR.stub(:request_over_http).and_return(xml)
    end

    it 'successfully with 200 status' do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET #show' do
    it 'should redirect to root when photo not found' do
      FLICKR.photos.stub(:find_by_id).and_raise(Flickr::Error.new)

      get :show, params: { id: 0 }
      expect(response).should redirect_to root_url
      expect(response).to have_http_status(302)
    end

    before do
      xml = File.read(File.join(Rails.root, 'spec/fixtures/photos', 'get_info-0.xml'))
      FLICKR.stub(:request_over_http).and_return(xml)
    end

    it 'successfully with 200 status' do
      get :show, params: { id: 'qwe' }
      expect(response).to have_http_status(200)
    end

    it 'render show template' do
      get :show, params: { id: 'qwe' }
      expect(response).to render_template(:show)
    end
  end
end

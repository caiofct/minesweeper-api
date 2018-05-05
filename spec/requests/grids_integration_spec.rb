require 'rails_helper'

RSpec.describe 'Grids Integration Spec', type: :request do
  describe "GET #index" do
    let(:user) { create(:user) }
    it "returns unauthorized when not authenticated" do
      get '/grids'
      expect(response).to have_http_status(:unauthorized)
    end

    it "returns http success when authenticated" do
      token = authenticate(user)
      get '/grids', headers: { 'Authorization' => "#{token['auth_token']}" }

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).length).to be 0
    end
  end

end

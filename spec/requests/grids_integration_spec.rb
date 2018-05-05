require 'rails_helper'

RSpec.describe 'Grids Integration Spec', type: :request do
  let(:user) { create(:user) }

  describe "GET #index" do
    it "returns unauthorized when not authenticated" do
      get '/grids'
      expect(response).to have_http_status(:unauthorized)
    end

    it "returns http success when authenticated" do
      token = authenticate(user)
      grid = create(:grid, user: user)
      get '/grids', headers: { 'Authorization' => "#{token['auth_token']}" }

      expect(response).to have_http_status(:success)
      grids = JSON.parse(response.body)
      expect(grids.length).to eq 1
      expect(grids.first['user_id']).to eq user.id
      expect(grids.first['id']).to eq grid.id
    end
  end

  describe "POST #create" do
    it "returns http success when created" do
      token = authenticate(user)
      post '/grids', headers: { 'Authorization' => "#{token['auth_token']}" },
                     params: { grid: { width: 5, height: 5, number_of_mines: 8 } }
      expect(response).to have_http_status(:success)
      expect(user.grids.length).to eq 1
    end

    it "returns errors when not valid" do
      token = authenticate(user)
      post '/grids', headers: { 'Authorization' => "#{token['auth_token']}" },
                     params: { grid: { width: -1, height: 0 } }
      expect(response).to have_http_status(422)
      errors = JSON.parse(response.body)
      expect(errors.length).to eq 4
      expect(user.grids.length).to eq 0
    end
  end

  describe "DELETE #destroy" do
    it "returns http success when destroyed" do
      token = authenticate(user)
      grid = create(:grid, user: user)

      delete grid_path(id: grid.id), headers: { 'Authorization' => "#{token['auth_token']}" }
      expect(response).to have_http_status(:success)
      expect(user.grids.length).to eq 0
    end

    it "cannot destroy a grid from another user" do
      token = authenticate(user)
      user2 = create(:user, email: Faker::Internet.email)
      grid = create(:grid, user: user2)

      delete grid_path(id: grid.id), headers: { 'Authorization' => "#{token['auth_token']}" }
      expect(response).to have_http_status(422)
      expect(user2.grids.length).to eq 1
    end
  end
end

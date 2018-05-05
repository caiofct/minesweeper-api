require 'rails_helper'

RSpec.describe 'Squares Integration Spec', type: :request do
  let(:user) { create(:user) }
  let(:grid) { create(:grid, user: user) }

  describe "GET #index" do
    it "returns unauthorized when not authenticated" do
      get "/grids/#{grid.id}/squares"
      expect(response).to have_http_status(:unauthorized)
    end

    it "returns the grid's squares when authenticated" do
      token = authenticate(user)

      get "/grids/#{grid.id}/squares", headers: { 'Authorization' => "#{token['auth_token']}" }
      expect(response).to have_http_status(:success)
      squares = JSON.parse(response.body)

      expect(grid.squares.length).to eq 100
      expect(grid.squares.where(mine: true).count).to eq 10
    end
  end

  describe "PUT #toggle_flag" do
    it "returns unauthorized when not authenticated" do
      put "/grids/#{grid.id}/squares/0/0/toggle_flag"
      expect(response).to have_http_status(:unauthorized)
    end

    it "returns the square toggled" do
      token = authenticate(user)

      put "/grids/#{grid.id}/squares/0/0/toggle_flag", headers: { 'Authorization' => "#{token['auth_token']}" }
      expect(response).to have_http_status(:success)
      square = JSON.parse(response.body)

      expect(grid.squares.first.id).to eq square['id']
      expect(grid.squares.reload.first.flagged).to eq true
    end
  end

  describe "PUT #explore" do
    it "returns unauthorized when not authenticated" do
      put "/grids/#{grid.id}/squares/0/0/explore"
      expect(response).to have_http_status(:unauthorized)
    end

    it "returns the square explored" do
      token = authenticate(user)

      put "/grids/#{grid.id}/squares/0/0/explore", headers: { 'Authorization' => "#{token['auth_token']}" }
      expect(response).to have_http_status(:success)
      first_square = grid.squares.reload.first
      expect(first_square.explored).to eq true
      if first_square.mine
        expect(grid.status).to eq "game_over"
      else
        expect(grid.status).to eq "playing"
      end
    end
  end
end

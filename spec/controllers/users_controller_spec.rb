require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "POST #create" do
    it "returns http success" do
      post :create, params: { name: Faker::Name.name, email: Faker::Internet.email, password: 'password' }
      expect(response).to have_http_status(:success)
    end

    it "returns error with invalid user" do
      post :create, params: { email: Faker::Internet.email, password: 'password' }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body).length).to eq 1
    end
  end
end

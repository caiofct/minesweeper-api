require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do

  describe "GET #authenticate" do
    let(:user) { create(:user) }
    it "returns http success" do
      get :authenticate, params: { email: user.email, password: user.password }
      expect(response).to have_http_status(:success)
    end

    it "returns unauthorized when invalid user" do
      get :authenticate, params: { email: 'test@test.com', password: 'test' }
      expect(response).to have_http_status(:unauthorized)
    end
  end

end

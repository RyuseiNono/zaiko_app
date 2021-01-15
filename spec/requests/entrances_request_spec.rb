require 'rails_helper'

RSpec.describe "Entrances", type: :request do

  describe "GET /registrations" do
    it "returns http success" do
      get "/entrances/registrations"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /sessions" do
    it "returns http success" do
      get "/entrances/sessions"
      expect(response).to have_http_status(:success)
    end
  end

end

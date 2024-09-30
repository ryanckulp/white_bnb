require 'rails_helper'

RSpec.describe "Addons", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/addons/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/addons/create"
      expect(response).to have_http_status(:success)
    end
  end

end

require 'rails_helper'

RSpec.describe "Reviews", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/reviews/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/reviews/create"
      expect(response).to have_http_status(:success)
    end
  end
end

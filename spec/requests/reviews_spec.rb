require 'rails_helper'

RSpec.describe "Reviews", type: :request do
  let(:valid_attributes) do
    { review: build(:review).attributes.except('id', 'approved', 'created_at', 'updated_at') }
  end

  let(:invalid_attributes) do
    { review: { title: 'title only' } }
  end

  describe "GET /new" do
    it "returns http success" do
      get new_review_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include('Leave a review')
    end

    it "pre-fills name and email" do
      email = 'jim.bubb@gmail.com'
      name = 'Jim Bob'

      get new_review_path(email: email, name: name)

      expect(response).to have_http_status(:success)
      expect(response.body).to include('Leave a review')
      expect(response.body).to include(email)
      expect(response.body).to include(name)
    end
  end

  describe "POST /create" do
    it "returns http success" do
      post "/reviews", params: valid_attributes

      expect(response).to have_http_status(302)
      follow_redirect! # redirects to home page

      expect(response.body).to include('Thanks for your review')
      expect(request.path).to eql '/'
    end

    it "returns validation errors" do
      post "/reviews", params: invalid_attributes

      expect(response).to have_http_status(422)
      expect(response.body).to include('errors prohibited this review from being saved')
      expect(response.body).to include("can&#39;t be blank")
    end
  end
end

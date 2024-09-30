require 'rails_helper'

RSpec.describe "Booking Addons", type: :request do
  before do
    @addon = create(:addon)
    @user = create(:user)
  end

  describe "GET /index" do
    it "returns http success" do
      sign_in(@user)
      get addons_path

      expect(response).to have_http_status(302)
      expect(response).to redirect_to(book_path)
    end
  end

  # describe "POST /create" do
  #   it "returns http success" do
  #     post addons_path
  #     expect(response).to have_http_status(:success)
  #   end
  # end
end

require 'rails_helper'

feature 'Login', js: true do
  include DeviseHelpers

  scenario 'Login should work' do
    user = create(:user)
    login(user)
    expect(page.text).to include('Dashboard')
  end
end

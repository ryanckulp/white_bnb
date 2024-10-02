require 'rails_helper'

feature 'Login', js: true do
  include DeviseHelpers

  scenario 'Login should work when user has no reservations' do
    user = create(:user)
    login(user)
    expect(page.text).to include('Select dates for your stay')
    expect(page.text).to include(Date.today.strftime('%B'))
  end

  scenario 'Login should work when user has reservations' do
    booking = create(:booking)
    login(booking.user)
    expect(page.text).to include('Reservations')
  end
end

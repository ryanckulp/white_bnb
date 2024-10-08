require 'rails_helper'

feature 'Registration', js: true do
  include DeviseHelpers

  scenario 'Registration should work' do
    expect { sign_up }.to change { User.count }.by(1)
    expect(page.text).to include('Book') # via after_sign_in_path_for
    expect(page.text).to include(Date.today.strftime('%B').upcase)
  end
end

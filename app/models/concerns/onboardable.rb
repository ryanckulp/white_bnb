module Onboardable
  extend ActiveSupport::Concern

  included do
    def self.create_guest
      create!(email: "guest-#{Time.now.to_i}@#{Rails.application.credentials.company_name.parameterize}.com", password: SecureRandom.hex(10))
    end
  end
end

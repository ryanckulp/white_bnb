module Onboardable
  extend ActiveSupport::Concern

  included do
    def self.create_guest
      create!(email: "guest-#{Time.now.to_i}@#{guest_email_domain}", password: SecureRandom.hex(10))
    end

    def self.guest_email_domain
      "#{Rails.application.credentials.company_name.parameterize}.com"
    end
  end
end

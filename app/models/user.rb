class User < ApplicationRecord
  include Signupable
  include Onboardable
  include Billable

  has_many :bookings, dependent: :destroy

  scope :subscribed, -> { where.not(stripe_subscription_id: [nil, '']) }

  # :nocov:
  def self.ransackable_attributes(*)
    ["id", "admin", "created_at", "updated_at", "email", "stripe_customer_id", "stripe_subscription_id", "paying_customer"]
  end

  def self.ransackable_associations(_auth_object)
    []
  end
  # :nocov:
end

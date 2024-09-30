class Booking < ApplicationRecord
  has_rich_text :notes
  belongs_to :user, optional: true

  validates :start_date, :end_date, presence: true

  has_many :booking_addons, dependent: :destroy

  scope :upcoming, -> { where('end_date >= ?', Date.today) }
  scope :unpaid, -> { where(stripe_payment_id: nil) }

  def addon_fees
    booking_addons.sum { |ba| ba.addon.price }.to_f
  end

  def payment
    Stripe::PaymentIntent.retrieve(stripe_payment_id)
  end

  def total_amount
    ((nights * Setting.per_night_price) + addon_fees).to_i # must be integer
  end

  def nights
    (end_date - start_date).to_i
  end

  def self.ransackable_associations(*)
    ["rich_text_notes", "user"]
  end

  def self.ransackable_attributes(*)
    ["created_at", "end_date", "id", "start_date", "stripe_payment_id", "updated_at", "user_id"]
  end
end

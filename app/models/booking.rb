class Booking < ApplicationRecord
  has_rich_text :notes
  belongs_to :user, optional: true

  validates :start_date, :end_date, presence: true

  has_many :booking_addons, dependent: :destroy

  scope :upcoming, -> { where('end_date >= ?', Date.today) }
  scope :unpaid, -> { where(stripe_payment_id: nil) }

  def self.ransackable_associations(*)
    ["rich_text_notes", "user"]
  end

  def self.ransackable_attributes(*)
    ["created_at", "end_date", "id", "start_date", "stripe_payment_id", "updated_at", "user_id"]
  end
end

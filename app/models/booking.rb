class Booking < ApplicationRecord
  has_rich_text :notes
  belongs_to :user

  validates :start_date, :end_date, presence: true

  def self.ransackable_associations(*)
    ["rich_text_notes", "user"]
  end

  def self.ransackable_attributes(*)
    ["created_at", "end_date", "id", "start_date", "stripe_payment_id", "updated_at", "user_id"]
  end
end

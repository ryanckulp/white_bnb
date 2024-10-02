class Booking < ApplicationRecord
  has_rich_text :notes
  belongs_to :user, optional: true

  validates :start_date, :end_date, presence: true
  validate :dates_dont_overlap, on: :create

  has_many :booking_addons, dependent: :destroy

  scope :upcoming, -> { where('end_date >= ?', Date.today) }
  scope :past, -> { where('end_date <= ?', Date.today) }
  scope :paid, -> { where.not(stripe_payment_id: nil) }
  scope :unpaid, -> { where(stripe_payment_id: nil) }

  def dates_dont_overlap
    # IDEA: support back-to-back bookings (where start_date for a booking == end_date for another booking)
    if Booking.where(start_date: start_date).exists?
      errors.add(:start_date, message: 'is already booked and not available')
    elsif Booking.where(end_date: end_date).exists?
      errors.add(:end_date, message: 'is already booked and not available')
    elsif Booking.where("start_date BETWEEN ? AND ?", start_date, end_date).exists? || Booking.where("end_date BETWEEN ? AND ?", start_date, end_date).exists?
      errors.add(:base, message: 'Another booking exists between these dates')
    end
  end

  def addon_fees
    booking_addons.sum { |ba| ba.addon.price }.to_f
  end

  def addon_titles
    booking_addons.map(&:addon).map(&:title).join(', ')
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

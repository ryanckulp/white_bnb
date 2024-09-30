class BookingAddon < ApplicationRecord
  belongs_to :booking
  belongs_to :addon
end

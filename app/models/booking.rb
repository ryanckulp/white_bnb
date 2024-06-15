class Booking < ApplicationRecord
  has_rich_text :notes
  belongs_to :user
end

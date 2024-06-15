class BookingsController < ApplicationController
  def index
    @bookings = Booking.where('end_date >= ?', Date.today)
  end
end
class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :require_booking

  def index
    @upcoming_bookings = current_user.bookings.upcoming.includes(:booking_addons).order(start_date: :asc)
    @past_bookings = current_user.bookings.past.includes(:booking_addons).order(end_date: :desc)
  end

  private

  def require_booking
    redirect_to book_path, notice: 'Make a booking to view your reservations' unless current_user.bookings.paid.exists?
  end
end

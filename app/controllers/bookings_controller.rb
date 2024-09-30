class BookingsController < ApplicationController
  before_action :reset_partial_bookings

  def index
    @bookings = Booking.upcoming # including paid/unpaid to avoid double booking (ex: if 2 users attempt to book same dates)
  end

  def create
    booking = Booking.new(booking_params)

    if booking.save
      create_and_sign_in_user unless current_user
      booking.update(user_id: current_user.id)
      status = 'created'
    else
      status = 'fail'
    end

    render json: { status: status }
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end

  # ex: user visits /addons, then decides to restart booking process
  def reset_partial_bookings
    return unless current_user

    current_user.bookings.upcoming.unpaid.destroy_all
  end

  def create_and_sign_in_user
    user = User.create!(email: "guest-#{Time.now.to_i}@#{Rails.application.credentials.company_name.parameterize}.com", password: SecureRandom.hex(10))
    sign_in(user)
  end
end

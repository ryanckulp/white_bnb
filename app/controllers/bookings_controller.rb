class BookingsController < ApplicationController
  def index
    @bookings = Booking.where('end_date >= ?', Date.today)
  end

  def create
    booking = Booking.new(booking_params)

    if booking.save
      create_and_sign_in_user unless current_user
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

  def create_and_sign_in_user
    user = User.create!(email: "guest-#{Time.now.to_i}@#{Rails.application.credentials.company_name.parameterize}.com", password: SecureRandom.hex(10))
    sign_in(user)
  end
end

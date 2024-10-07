class BookingsController < ApplicationController
  before_action :clear_stale_bookings

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
      message = booking.errors.full_messages
    end

    render json: { status: status, message: message }
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end

  def clear_stale_bookings
    Booking.stale.where(created_at: 7.days.ago..1.hour.ago).destroy_all # abandoned cart
    current_user.bookings.stale.destroy_all if current_user # user restarts process
  end

  def create_and_sign_in_user
    user = User.create_guest
    sign_in(user)
  end
end

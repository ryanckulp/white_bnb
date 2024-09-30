class AddonsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking

  def index
    @addons = Addon.all
  end

  def create
    # TODO: handle errors, too optimistic now
    addon_params.each_key do |addon_id|
      @booking.booking_addons.create(addon_id: addon_id)
    end

    redirect_to subscribe_index_path
  end

  private

  def addon_params
    params.require(:addons).permit!
  end

  def set_booking
    @booking = current_user.bookings.find_by(id: session[:current_booking_id])
    redirect_to book_path, alert: 'Cannot choose addons without an active booking' unless @booking
  end
end
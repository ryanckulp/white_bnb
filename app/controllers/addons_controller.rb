class AddonsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking
  before_action :set_addons

  def index
    @booking.booking_addons.destroy_all # reset in case user comes back from Checkout
  end

  def create
    # TODO: handle errors, too optimistic now
    addon_params.each_key do |addon_id|
      @booking.booking_addons.create(addon_id: addon_id)
    end

    redirect_to checkout_index_path
  end

  private

  def addon_params
    params.fetch(:addons, {}).permit!
  end

  def set_addons
    @addons = Addon.all
    redirect_to checkout_index_path unless @addons.present? # optional feature
  end
end

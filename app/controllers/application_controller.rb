class ApplicationController < ActionController::Base
  impersonates :user

  def authenticate_admin!(alert_message: nil)
    redirect_to new_user_session_path, alert: alert_message unless current_user&.admin?
  end

  def after_sign_in_path_for(resource)
    resource.bookings.paid.exists? ? dashboard_index_path : book_path
  end

  private

  def set_booking
    @booking = current_user.current_booking

    respond_to do |format|
      # format.turbo_stream { redirect_to book_path, alert: 'Cannot choose addons without an active booking' unless @booking }
      format.html { redirect_to book_path, alert: 'Cannot choose addons without an active booking' unless @booking }
      format.json { render json: { status: 'fail' } unless @booking } # via PaymentsController
    end
  end
end

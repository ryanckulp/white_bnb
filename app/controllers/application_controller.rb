class ApplicationController < ActionController::Base
  impersonates :user

  # uncomment to allow extra User model params during registration (beyond email/password)
  # before_action :configure_permitted_parameters, if: :devise_controller?

  def authenticate_admin!(alert_message: nil)
    redirect_to new_user_session_path, alert: alert_message unless current_user&.admin?
  end

  def after_sign_in_path_for(resource)
    resource.bookings.present? ? dashboard_index_path : book_path
  end

  def reset_current_booking
    session.delete(:current_booking_id)
  end
end

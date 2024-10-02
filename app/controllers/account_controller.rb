class AccountController < ApplicationController
  before_action :authenticate_user!

  def index; end

  def update
    current_user.update(account_update_params)
    bypass_sign_in(current_user) # prevents user from needing to log back in

    respond_to do |format|
      format.html { redirect_to account_index_path, notice: 'Profile updated successfully' }
      format.json { render json: { email: current_user.email } } # via CheckoutsController#index
    end
  end

  def stop_impersonating
    stop_impersonating_user
    redirect_to admin_root_path
  end

  private

  def account_update_params
    params.require(:user).permit(:email, :password)
  end
end

class AccountController < ApplicationController
  before_action :authenticate_user!

  def index; end

  def update
    if current_user.update(account_update_params)
      bypass_sign_in(current_user) # prevents user from needing to log back in
      updated = true
    end

    respond_to do |format|
      if updated
        format.html { redirect_to account_index_path, notice: 'Profile updated successfully' }
        format.json { render json: { email: current_user.email } } # via CheckoutsController#index
      else
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: { email: current_user.reload.email, error: true } }
      end
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

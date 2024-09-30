class CheckoutController < ApplicationController
  before_action :authenticate_user!

  def index
    ab_finished(:cta, reset: false) # reset:false prevents a user from triggering duplicate completions
  end
end

class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    render json: create_payment_intent # /checkout view
  end

  def confirm
    payment_intent = Stripe::PaymentIntent.retrieve(params[:payment_intent])

    if payment_intent.status == 'succeeded'
      @booking.update(stripe_payment_id: payment_intent.id)
      reset_current_booking
      redirect_to thanks_path
    else
      redirect_to checkout_index_path, alert: "Something went wrong, please try again."
    end
  end

  private

  def create_payment_intent
    payment_intent = Stripe::PaymentIntent.create(
      amount: @booking.total_amount * 100, # must be in cents
      setup_future_usage: 'off_session',
      currency: 'usd',
      automatic_payment_methods: { enabled: true }
    )

    { clientSecret: payment_intent.client_secret, amount: @booking.total_amount, nights: @booking.nights, addonFees: @booking.addon_fees }
  end

  def set_booking
    @booking = current_user.bookings.find_by(id: session[:current_booking_id])
    render json: { status: 'fail' } unless @booking
  end
end

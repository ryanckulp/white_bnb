class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking
  before_action :set_coupon, only: [:create]

  def create
    payment_intent = Stripe::PaymentIntent.create(
      amount: amount_in_cents,
      customer: current_user.stripe_customer_id,
      setup_future_usage: 'off_session',
      currency: 'usd',
      automatic_payment_methods: { enabled: true }
    )

    render json: { clientSecret: payment_intent.client_secret, amount: amount_in_dollars, nights: @booking.nights, addonFees: @booking.addon_fees, couponAmount: coupon_amount_in_dollars }
  end

  def confirm
    payment_intent = Stripe::PaymentIntent.retrieve(params[:payment_intent])

    if payment_intent.status == 'succeeded'
      @booking.update(stripe_payment_id: payment_intent.id)
      redirect_to thanks_path
    else
      redirect_to checkout_index_path, alert: "Something went wrong, please try again."
    end
  end

  private

  def set_coupon
    @coupon = begin
      Stripe::Coupon.retrieve(params[:coupon]) if params.key?(:coupon)
    rescue Stripe::InvalidRequestError
      nil
    end
  end

  def coupon_amount_in_dollars
    ((@coupon&.amount_off || 0) / 100.0)
  end

  def amount_in_dollars
    @booking.total_amount - coupon_amount_in_dollars
  end

  def amount_in_cents
    (@booking.total_amount * 100) - (@coupon&.amount_off || 0)
  end
end

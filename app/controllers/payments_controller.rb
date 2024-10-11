class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking
  before_action :set_coupon, only: [:create]

  def create
    intent = if intent_type == 'payment'
               Stripe::PaymentIntent.create(
                 amount: amount_in_cents,
                 customer: current_user.stripe_customer_id,
                 setup_future_usage: 'off_session',
                 currency: 'usd',
                 automatic_payment_methods: { enabled: true }
               )
             else # when coupon value >= amount owed
               Stripe::SetupIntent.create(
                 customer: current_user.stripe_customer_id,
                 usage: 'off_session',
                 automatic_payment_methods: { enabled: true }
               )
             end

    render json: { clientSecret: intent.client_secret, intentType: intent_type, amount: amount_in_dollars, nights: @booking.nights, addonFees: @booking.addon_fees, couponAmount: coupon_amount_in_dollars }
  end

  def confirm
    intent = if params[:payment_intent]
               Stripe::PaymentIntent.retrieve(params[:payment_intent])
             else
               Stripe::SetupIntent.retrieve(params[:setup_intent])
             end

    if intent.status == 'succeeded'
      @booking.update(stripe_payment_id: intent.id)
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

  def intent_type
    amount_in_cents > 50 ? 'payment' : 'setup'
  end

  def coupon_amount_in_dollars
    if @coupon.percent_off
      @booking.total_amount * (@coupon.percent_off / 100.0)
    elsif @coupon.amount_off
      @coupon.amount_off / 100.0
    else
      0.0
    end
  end

  def amount_in_dollars
    @booking.total_amount - coupon_amount_in_dollars
  end

  def amount_in_cents
    amount_in_dollars * 100
  end
end

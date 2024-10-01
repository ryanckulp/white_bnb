module Billable
  extend ActiveSupport::Concern

  included do
    after_create :setup_stripe_customer
    after_update_commit :update_stripe_customer
  end

  # done after signup for easy CVR metrics via Stripe UI
  def setup_stripe_customer
    return unless Stripe.api_key.present?

    customer = Stripe::Customer.create({
      email: self.email,
      metadata: {
        external_id: self.id
      }
    })

    update(stripe_customer_id: customer.id)
  end

  def update_stripe_customer
    return unless stripe_customer

    # assign other attributes as desired
    Stripe::Customer.update(stripe_customer_id, { email: self.email })
  end

  def stripe_customer
    @stripe_customer ||= Stripe::Customer.retrieve({
      id: stripe_customer_id,
      expand: ['subscriptions']
    })
  end
end

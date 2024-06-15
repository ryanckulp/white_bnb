FactoryBot.define do
  factory :booking do
    start_date { Date.today }
    end_date { Date.today + 7 }
    stripe_payment_id { 'pi_asdfwqerty' }
    user
  end
end

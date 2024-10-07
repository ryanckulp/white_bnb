FactoryBot.define do
  factory :announcement do
    title { 'We. Are. Live.' }
    body { "Book now! Time to <strong>focus</strong> in <i>style</i>." }
    date { Date.today }
    version { "0.0.1" }
    published { false }
  end
end

FactoryBot.define do
  factory :review do
    title { 'Just Wonderful' }
    body { "I can't think of a more productive trip." }
    name { 'Jim Bob' }
    email { 'jimbob@gmail.com' }
    job_title { 'CEO, Swamp Tours LLC' }
    approved { false }
  end
end

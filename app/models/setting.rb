class Setting < ApplicationRecord

  validates_presence_of :key, :value

  def self.per_night_price
    (find_by_key('per_night_price')&.value || 0).to_f
  end

  # :nocov:
  def self.ransackable_attributes(*)
    ["created_at", "id", "id_value", "key", "updated_at", "value"]
  end
  # :nocov:
end

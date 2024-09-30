class Setting < ApplicationRecord

  validates_presence_of :key, :value

  # :nocov:
  def self.ransackable_attributes(*)
    ["created_at", "id", "id_value", "key", "updated_at", "value"]
  end
  # :nocov:
end

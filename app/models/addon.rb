class Addon < ApplicationRecord
  validates_presence_of :title, :price

  def self.ransackable_attributes(*)
    ["created_at", "description", "id", "price", "title", "updated_at"]
  end
end

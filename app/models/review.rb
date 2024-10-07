class Review < ApplicationRecord
  validates :title, :body, :name, :email, presence: true

  scope :approved, -> { where(approved: true) }

  # :nocov:
  def self.ransackable_attributes(*)
    ["approved", "body", "created_at", "email", "id", "id_value", "job_title", "name", "title", "updated_at"]
  end
  # :nocov:
end

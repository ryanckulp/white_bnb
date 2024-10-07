class Announcement < ApplicationRecord
  has_rich_text :body

  validates :title, :body, :date, :version, presence: true

  scope :published, -> { where(published: true) }
  scope :newest_to_oldest, -> { order(date: :desc) }

  attribute :date, default: Date.today

  # :nocov:
  def self.ransackable_attributes(*)
    ["created_at", "date", "id", "published", "title", "version", "updated_at"]
  end

  def self.ransackable_associations(*)
    ["rich_text_body"]
  end
  # :nocov:

end

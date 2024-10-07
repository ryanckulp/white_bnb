class ActionText::Record < ActiveRecord::Base
  def self.ransackable_attributes(*)
    authorizable_ransackable_attributes
  end
end

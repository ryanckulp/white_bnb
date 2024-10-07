require 'rails_helper'

RSpec.describe Announcement, type: :model do
  subject { build(:announcement) }

  it 'has a valid factory' do
    expect(subject).to be_valid
  end

  describe 'ActiveModel validations' do
    it { expect(subject).to validate_presence_of(:title) }
    it { expect(subject).to validate_presence_of(:body) }
    it { expect(subject).to validate_presence_of(:date) }
    it { expect(subject).to validate_presence_of(:version) }
  end
end

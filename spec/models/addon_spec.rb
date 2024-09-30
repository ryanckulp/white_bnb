require 'rails_helper'

RSpec.describe Addon, type: :model do
  subject { build(:addon) }

  it 'has a valid factory' do
    expect(subject).to be_valid
  end

  describe 'ActiveModel validations' do
    it { expect(subject).to validate_presence_of(:title) }
    it { expect(subject).to validate_presence_of(:price) }
  end
end

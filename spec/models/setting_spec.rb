require 'rails_helper'

RSpec.describe Setting, type: :model do
  subject { build(:setting) }

  it 'has a valid factory' do
    expect(subject).to be_valid
  end

  describe 'ActiveModel validations' do
    it { expect(subject).to validate_presence_of(:key) }
    it { expect(subject).to validate_presence_of(:value) }
  end
end

require 'rails_helper'

RSpec.describe Booking, type: :model do
  subject { build(:booking) }

  it 'has a valid factory' do
    expect(subject).to be_valid
  end

  describe 'ActiveModel associations' do
    it { expect(subject).to belong_to(:user) }
  end
end

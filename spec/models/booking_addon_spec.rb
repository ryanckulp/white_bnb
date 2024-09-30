require 'rails_helper'

RSpec.describe BookingAddon, type: :model do
  subject { build(:booking_addon) }

  it 'has a valid factory' do
    expect(subject).to be_valid
  end

  describe 'ActiveModel associations' do
    it { expect(subject).to belong_to(:booking) }
    it { expect(subject).to belong_to(:addon) }
  end
end

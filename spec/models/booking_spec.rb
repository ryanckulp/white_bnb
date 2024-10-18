require 'rails_helper'

RSpec.describe Booking, type: :model do
  subject { build(:booking) }

  it 'has a valid factory' do
    expect(subject).to be_valid
  end

  describe 'ActiveModel associations' do
    it { expect(subject).to belong_to(:user).without_validating_presence }
    it { expect(subject).to have_many(:booking_addons) }
  end

  describe 'ActiveModel validations' do
    it { expect(subject).to validate_presence_of(:start_date) }
    it { expect(subject).to validate_presence_of(:end_date) }
  end

  describe 'custom validations' do
    it 'should not allow duplicate start_date' do
      subject.save
      duplicate_start_date = subject.start_date

      new_booking = build(:booking, start_date: duplicate_start_date)
      expect(new_booking.valid?).to be false
      expect(new_booking.errors.full_messages).to include('Start date is already booked and not available')
    end

    it 'should not allow duplicate end_date' do
      subject.save
      unique_start_date = subject.start_date - 1.day
      duplicate_end_date = subject.end_date

      new_booking = build(:booking, start_date: unique_start_date, end_date: duplicate_end_date)
      expect(new_booking.valid?).to be false
      expect(new_booking.errors.full_messages).to include('End date is already booked and not available')
    end

    it 'should not allow start_date or end_date to overlap with another booking' do
      subject.save
      overlapping_start_date = subject.start_date + 1.day
      unique_end_date = subject.end_date + 1.day

      new_booking = build(:booking, start_date: overlapping_start_date, end_date: unique_end_date)
      expect(new_booking.valid?).to be false
      expect(new_booking.errors.full_messages).to include('Another booking exists between these dates')

      unique_start_date = subject.start_date - 1.day
      overlapping_end_date = subject.end_date - 1.day

      new_booking = build(:booking, start_date: unique_start_date, end_date: overlapping_end_date)
      expect(new_booking.valid?).to be false
      expect(new_booking.errors.full_messages).to include('Another booking exists between these dates')
    end

    it 'should not allow bookings shorter than the minimum stay length' do
      Setting.create!(key: 'minimum_stay_length', value: subject.nights + 1)

      expect(subject.valid?).to be false
      expect(subject.errors.full_messages).to include("Stay must be at least #{subject.nights + 1} nights")
    end
  end
end

class RemoveBookingUserNullConstraint < ActiveRecord::Migration[8.0]
  def change
    change_column_null :bookings, :user_id, true
  end
end

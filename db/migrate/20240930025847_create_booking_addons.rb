class CreateBookingAddons < ActiveRecord::Migration[8.0]
  def change
    create_table :booking_addons do |t|
      t.references :booking, null: false, foreign_key: true
      t.references :addon, null: false, foreign_key: true
    end
  end
end

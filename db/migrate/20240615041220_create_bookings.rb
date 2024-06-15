class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.date :start_date
      t.date :end_date
      t.string :stripe_payment_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

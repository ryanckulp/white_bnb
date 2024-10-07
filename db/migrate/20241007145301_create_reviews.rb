class CreateReviews < ActiveRecord::Migration[8.0]
  def change
    create_table :reviews do |t|
      t.string :title
      t.text :body
      t.string :name
      t.string :job_title
      t.string :email
      t.boolean :approved, default: false, null: false

      t.timestamps
    end
  end
end

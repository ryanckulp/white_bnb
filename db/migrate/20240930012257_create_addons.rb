class CreateAddons < ActiveRecord::Migration[8.0]
  def change
    create_table :addons do |t|
      t.string :title
      t.text :description
      t.decimal :price

      t.timestamps
    end
  end
end
